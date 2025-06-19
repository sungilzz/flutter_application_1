import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/recipe_auth_app.dart';
import 'package:flutter_application_1/auth/screens/sign_in_screen.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class RecipeAuthAppState extends State<RecipeAuthApp> {
  // Manage the current displayed screen
  Widget _currentScreen = const SignInScreen();

  void navigateTo(Widget screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the vibrant, food-inspired color scheme
    final ColorScheme customColorScheme = ColorScheme.light(
      primary: const Color(0xFF6200EE), // A base purple for primary actions
      primaryContainer: const Color(0xFFBB86FC),
      secondary: const Color(0xFF03DAC6), // A vibrant teal for accents
      secondaryContainer: const Color(0xFF018786),
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

    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: customColorScheme,
        scaffoldBackgroundColor: Colors.grey[50], // Match background
        fontFamily: 'Inter', // Prefer Inter as requested, or system default
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
          labelLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ), // For buttons
          labelMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ), // For links
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: customColorScheme.primary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: customColorScheme.primary, // Primary button color
            foregroundColor:
                customColorScheme.onPrimary, // Text color on primary
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            elevation: 3,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: customColorScheme.primary, // Link color
            textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: _currentScreen, // Display the current screen
    );
  }
}
