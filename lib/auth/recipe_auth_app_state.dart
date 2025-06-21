import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/recipe_auth_app.dart';
import 'package:flutter_application_1/auth/screens/maintenance_screen.dart';
import 'package:flutter_application_1/auth/screens/sign_in_screen.dart';
import 'package:flutter_application_1/main/main_screen.dart';
import 'package:flutter_application_1/onboarding/welcome_screen.dart';

class RecipeAuthAppState extends State<RecipeAuthApp> {
  // Manage the current displayed screen
  Widget? _currentScreen;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _checkAuthAndOnboarding();
  }

  Future<void> _checkAuthAndOnboarding() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _currentScreen = const SignInScreen();
        _initialized = true;
      });
      return;
    }
    try {
      // Check onboarding status from Firestore (users/{uid}/onboarding)
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .timeout(const Duration(seconds: 5));
      final onboarding = doc.data()?['onboarding'] as bool?;
      if (onboarding == true) {
        setState(() {
          _currentScreen = const MainScreen();
          _initialized = true;
        });
      } else {
        setState(() {
          _currentScreen = const WelcomeScreen();
          _initialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _currentScreen = const MaintenanceScreen();
        _initialized = true;
      });
    }
  }

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
            borderSide: BorderSide(width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
      home: _initialized && _currentScreen != null
          ? _currentScreen!
          : const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
