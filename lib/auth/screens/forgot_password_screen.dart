import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/recipe_auth_app_state.dart';
import 'package:flutter_application_1/auth/screens/sign_in_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                'Reset Your Password',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),

              Text(
                'Enter your email address and we\'ll send you a link to reset your password.',
                style: Theme.of(context).textTheme.bodyLarge,
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
              const SizedBox(height: 32.0),

              // Reset Password Button
              ElevatedButton(
                onPressed: () {
                  // Mock reset action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password reset link sent (mock)!'),
                    ),
                  );
                },
                child: const Text('Reset Password'),
              ),
              const SizedBox(height: 48.0),

              // Back to Sign In Link
              TextButton(
                onPressed: () {
                  (context.findAncestorStateOfType<RecipeAuthAppState>())
                      ?.navigateTo(const SignInScreen());
                },
                child: const Text('Back to Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
