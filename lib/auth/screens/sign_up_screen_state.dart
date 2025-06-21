import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/recipe_auth_app_state.dart';
import 'package:flutter_application_1/auth/screens/sign_in_screen.dart';
import 'package:flutter_application_1/auth/screens/sign_up_screen.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordLengthValid = false;
  bool _isPasswordUppercaseValid = false;
  bool _isPasswordNumberValid = false;
  bool _isPasswordSpecialValid = false;
  bool _passwordsMatch = false;
  String? _errorMessage;

  void _validatePassword(String password) {
    setState(() {
      _isPasswordLengthValid = password.length >= 8;
      _isPasswordUppercaseValid = password.contains(RegExp(r'[A-Z]'));
      _isPasswordNumberValid = password.contains(RegExp(r'[0-9]'));
      _isPasswordSpecialValid = password.contains(
        RegExp(r'[!@#\$%^&*()_+\-=\[\]{};":\\|,.<>\/?]'),
      );
      _passwordsMatch = password == _confirmPasswordController.text;
    });
  }

  void _checkConfirmPassword(String confirmPassword) {
    setState(() {
      _passwordsMatch = _passwordController.text == confirmPassword;
    });
  }

  Future<void> _signUp() async {
    setState(() {
      _errorMessage = null;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty ||
        !_isPasswordLengthValid ||
        !_isPasswordUppercaseValid ||
        !_isPasswordNumberValid ||
        !_isPasswordSpecialValid ||
        !_passwordsMatch) {
      setState(() {
        _errorMessage =
            AppLocalizations.of(context)?.translate('signUp.errorFillFields') ??
            "Please fill all fields correctly.";
      });
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user?.sendEmailVerification();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)?.translate('signUp.success') ??
                  'Sign up successful! Verification email sent.',
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? "Sign up failed.";
      });
    } catch (e) {
      setState(() {
        _errorMessage = "An unknown error occurred.";
      });
    }
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
                AppLocalizations.of(context)?.translate('signUp.title') ??
                    'Create Your Account',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )?.translate('signUp.emailHint') ??
                      'Email Address',
                  prefixIcon: const Icon(Icons.mail_outline),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )?.translate('signUp.passwordHint') ??
                      'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                obscureText: true,
                onChanged: _validatePassword,
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPasswordRequirement(
                    AppLocalizations.of(
                          context,
                        )?.translate('signUp.min8Chars') ??
                        'Minimum 8 characters',
                    _isPasswordLengthValid,
                    context,
                  ),
                  _buildPasswordRequirement(
                    AppLocalizations.of(
                          context,
                        )?.translate('signUp.oneUpper') ??
                        'At least one uppercase letter',
                    _isPasswordUppercaseValid,
                    context,
                  ),
                  _buildPasswordRequirement(
                    AppLocalizations.of(
                          context,
                        )?.translate('signUp.oneNumber') ??
                        'At least one number',
                    _isPasswordNumberValid,
                    context,
                  ),
                  _buildPasswordRequirement(
                    AppLocalizations.of(
                          context,
                        )?.translate('signUp.oneSpecial') ??
                        'At least one special character (!@#\$ etc.)',
                    _isPasswordSpecialValid,
                    context,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )?.translate('signUp.confirmPasswordHint') ??
                      'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  errorText:
                      _confirmPasswordController.text.isNotEmpty &&
                          !_passwordsMatch
                      ? AppLocalizations.of(
                              context,
                            )?.translate('signUp.passwordsNoMatch') ??
                            'Passwords do not match.'
                      : null,
                ),
                obscureText: true,
                onChanged: _checkConfirmPassword,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _signUp,
                child: Text(
                  AppLocalizations.of(context)?.translate('signUp.signUp') ??
                      'Sign Up',
                ),
              ),
              const SizedBox(height: 48.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(
                          context,
                        )?.translate('signUp.alreadyHaveAccount') ??
                        "Already have an account?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      (context.findAncestorStateOfType<RecipeAuthAppState>())
                          ?.navigateTo(const SignInScreen());
                    },
                    child: Text(
                      AppLocalizations.of(
                            context,
                          )?.translate('signIn.signIn') ??
                          'Sign In',
                    ),
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
    bool valid,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            valid ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: valid ? Colors.green : Colors.red,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: valid ? Colors.green[700] : Colors.red[700],
            ),
          ),
        ],
      ),
    );
  }
}
