import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/recipe_auth_app_state.dart';
import 'package:flutter_application_1/auth/screens/sign_in_screen.dart';
import 'package:flutter_application_1/auth/screens/sign_up_screen.dart';

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordLengthValid = false;
  bool _isPasswordUppercaseValid = false;
  bool _isPasswordNumberValid = false;
  bool _isPasswordSpecialValid = false;
  bool _passwordsMatch = false;

  void _validatePassword(String password) {
    setState(() {
      _isPasswordLengthValid = password.length >= 8;
      _isPasswordUppercaseValid = password.contains(RegExp(r'[A-Z]'));
      _isPasswordNumberValid = password.contains(RegExp(r'[0-9]'));
      _isPasswordSpecialValid = password.contains(
        RegExp(r'[!@#$%^&*()_+\-=\[\]{};":\\|,.<>\/?]'),
      );
      _passwordsMatch = password == _confirmPasswordController.text;
    });
  }

  void _checkConfirmPassword(String confirmPassword) {
    setState(() {
      _passwordsMatch = _passwordController.text == confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create Your Account',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),

              // Email Field
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                onChanged: _validatePassword,
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPasswordRequirement(
                    'Minimum 8 characters',
                    _isPasswordLengthValid,
                    context,
                  ),
                  _buildPasswordRequirement(
                    'At least one uppercase letter',
                    _isPasswordUppercaseValid,
                    context,
                  ),
                  _buildPasswordRequirement(
                    'At least one number',
                    _isPasswordNumberValid,
                    context,
                  ),
                  _buildPasswordRequirement(
                    'At least one special character (!@#\$ etc.)',
                    _isPasswordSpecialValid,
                    context,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  errorText:
                      _confirmPasswordController.text.isNotEmpty &&
                          !_passwordsMatch
                      ? 'Passwords do not match.'
                      : null,
                ),
                obscureText: true,
                onChanged: _checkConfirmPassword,
              ),
              const SizedBox(height: 32.0),

              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Mock sign-up action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Attempting to sign up...')),
                  );
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 48.0),

              // Already have an account? Sign In Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      (context.findAncestorStateOfType<RecipeAuthAppState>())
                          ?.navigateTo(const SignInScreen());
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(
    String text,
    bool isValid,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: isValid ? Colors.green : Colors.red,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isValid ? Colors.green[700] : Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }
}
