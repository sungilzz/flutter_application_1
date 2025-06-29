import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/facebook_sign_in_helper.dart';
import 'package:flutter_application_1/auth/google_sign_in_helper.dart';
import 'package:flutter_application_1/auth/recipe_auth_app_state.dart';
import 'package:flutter_application_1/auth/screens/forgot_password_screen.dart';
import 'package:flutter_application_1/auth/screens/sign_up_screen.dart';
import 'package:flutter_application_1/auth/screens/social_sign_in_button.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    String? _errorMessage;

    Future<void> _signIn() async {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(
                      context,
                    )?.translate('signIn.emailSignInSuccess') ??
                    'Sign in successful!',
              ),
            ),
          );
          RecipeAuthAppState.of(context)?.checkAuthAndOnboarding();
        }
      } on FirebaseAuthException catch (e) {
        _errorMessage =
            AppLocalizations.of(
              context,
            )?.translate('signIn.emailSignInFailed') ??
            'Sign in failed. Please check your credentials.';
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(_errorMessage!)));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo/Recipe Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    '🍽️', // Food-related emoji for a friendly touch
                    style: TextStyle(fontSize: 60.0),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Text(
                AppLocalizations.of(context)?.translate('signIn.welcome') ?? '',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context)?.translate('signIn.email') ??
                      '',
                  prefixIcon: const Icon(Icons.mail_outline),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )?.translate('signIn.password') ??
                      '',
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),

              // Sign In Button
              ElevatedButton(
                onPressed: _signIn,
                child: Text(
                  AppLocalizations.of(context)?.translate('signIn.signIn') ??
                      '',
                ),
              ),
              const SizedBox(height: 16.0),

              // Don't have an account? Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(
                          context,
                        )?.translate('signIn.dontHaveAccount') ??
                        '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      (context.findAncestorStateOfType<RecipeAuthAppState>())
                          ?.navigateTo(const SignUpScreen());
                    },
                    child: Text(
                      AppLocalizations.of(
                            context,
                          )?.translate('signIn.signUp') ??
                          '',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),

              // OR Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      AppLocalizations.of(context)?.translate('signIn.or') ??
                          '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: 32.0),

              // Social Sign-In Buttons
              SocialSignInButton(
                provider: 'Google',
                backgroundColor: const Color(0xFFDB4437), // Google Red
                icon: Icons.g_mobiledata, // Using a generic icon for mock
                imageUrl:
                    'https://fonts.gstatic.com/s/i/productlogos/googleg/v6/24px.svg', // Placeholder
                onPressed: () async {
                  final userCredential =
                      await GoogleSignInHelper.signInWithGoogle();
                  if (userCredential != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate('signIn.googleSignInSuccess') ??
                              'Google sign-in successful!',
                        ),
                      ),
                    );
                    RecipeAuthAppState.of(context)?.checkAuthAndOnboarding();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate('signIn.googleSignInFailed') ??
                              'Google sign-in failed or cancelled.',
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              // SocialSignInButton(
              //   provider: 'Apple',
              //   backgroundColor: Colors.black,
              //   icon: Icons.apple, // Using a generic icon for mock
              //   imageUrl:
              //       'https://fonts.gstatic.com/s/i/productlogos/apple_black/v6/24px.svg', // Placeholder
              // ),
              const SizedBox(height: 16.0),
              SocialSignInButton(
                provider: 'Facebook',
                backgroundColor: const Color(0xFF4267B2), // Facebook Blue
                icon: Icons.facebook, // Using a generic icon for mock
                imageUrl:
                    'https://fonts.gstatic.com/s/i/productlogos/facebook_24dp/v6/24px.svg', // Placeholder
                onPressed: () async {
                  final userCredential =
                      await FacebookSignInHelper.signInWithFacebook();
                  if (userCredential != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate('signIn.facebookSignInSuccess') ??
                              'Facebook sign-in successful!',
                        ),
                      ),
                    );
                    RecipeAuthAppState.of(context)?.checkAuthAndOnboarding();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                                context,
                              )?.translate('signIn.facebookSignInFailed') ??
                              'Facebook sign-in failed or cancelled.',
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 10.0),

              // Forgot Password Link (moved to bottom)
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    (context.findAncestorStateOfType<RecipeAuthAppState>())
                        ?.navigateTo(const ForgotPasswordScreen());
                  },
                  child: Text(
                    AppLocalizations.of(
                          context,
                        )?.translate('signIn.forgotPassword') ??
                        '',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
