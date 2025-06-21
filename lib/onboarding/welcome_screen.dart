import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/country_dropdown.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

import 'preference_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the vibrant, food-inspired color scheme for this screen's context
    // In a full app, this would typically be defined at the MaterialApp level.
    final ColorScheme customColorScheme = ColorScheme.light(
      primary: const Color(
        0xFFE57373,
      ), // A soft red/coral, reminiscent of tomatoes/berries
      primaryContainer: const Color(0xFFFFCDD2),
      secondary: const Color(
        0xFF81C784,
      ), // A vibrant green, like avocado or fresh herbs
      secondaryContainer: const Color(0xFFC8E6C9),
      surface: Colors.white,
      background: Colors.grey[50]!, // Light background for clean aesthetic
      error: Colors.red[700]!,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black87,
      onBackground: Colors.black87,
      onError: Colors.white,
      brightness: Brightness.light,
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for a large, appealing recipe image or animation
              // This could be a static image, a looping video, or an animation
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white, // Changed background color to white
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              Text(
                AppLocalizations.of(context)?.translate('welcome.title') ??
                    'Personalize Your Recipe Journey',
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text(
                AppLocalizations.of(context)?.translate('welcome.subtitle') ??
                    "Tell us a little about your tastes and dietary needs so we can find recipes you'll love!",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PreferenceScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      customColorScheme.primary, // Primary button color
                  foregroundColor:
                      customColorScheme.onPrimary, // Text color on primary
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                  elevation: 3,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppLocalizations.of(context)?.translate('welcome.button') ??
                        'Get Started',
                  ),
                ),
              ),
              // Country selection dropdown at the bottom
              const SizedBox(height: 32.0),
              CountryDropdown(
                onChanged: (countryCode, locale) {
                  // Change the app's locale if your app supports it
                  // Example: MyApp.setLocale(context, locale);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
