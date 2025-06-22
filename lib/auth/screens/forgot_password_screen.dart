import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/recipe_auth_app_state.dart';
import 'package:flutter_application_1/auth/screens/sign_in_screen.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate('forgotPassword.title') ??
                    'Reset Your Password',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),

              Text(
                AppLocalizations.of(
                      context,
                    )?.translate('forgotPassword.instructions') ??
                    'Enter your email address and we\'ll send you a link to reset your password.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )?.translate('forgotPassword.emailHint') ??
                      'Email Address',
                  prefixIcon: const Icon(Icons.mail_outline),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32.0),

              // Reset Password Button
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text.trim();
                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate('forgotPassword.errorEmptyEmail') ??
                              'Please enter your email address.',
                        ),
                      ),
                    );
                    return;
                  }
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: email,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate('forgotPassword.success') ??
                              'Password reset link sent! Please check your email.',
                        ),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    String errorMsg =
                        AppLocalizations.of(
                          context,
                        )?.translate('forgotPassword.success') ??
                        'Password reset link sent! Please check your email.';
                    if (e.code == 'invalid-email') {
                      errorMsg =
                          AppLocalizations.of(
                            context,
                          )?.translate('forgotPassword.errorInvalidEmail') ??
                          'Invalid email address.';
                    }
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(errorMsg)));
                  }
                },
                child: Text(
                  AppLocalizations.of(
                        context,
                      )?.translate('forgotPassword.resetButton') ??
                      'Reset Password',
                ),
              ),
              const SizedBox(height: 48.0),

              // Back to Sign In Link
              TextButton(
                onPressed: () {
                  (context.findAncestorStateOfType<RecipeAuthAppState>())
                      ?.navigateTo(const SignInScreen());
                },
                child: Text(
                  AppLocalizations.of(
                        context,
                      )?.translate('forgotPassword.backToSignIn') ??
                      'Back to Sign In',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
