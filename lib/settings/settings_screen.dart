import 'package:flutter/material.dart';

import 'change_email_screen.dart';
import 'payment_history_screen.dart';
import 'reset_password_flow_screen.dart';

// Define a global navigator key to manage navigation easily from anywhere
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

// Wrapper for the Settings App to provide MaterialApp context
class SettingsAppWrapper extends StatelessWidget {
  const SettingsAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the vibrant, food-inspired color scheme
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

    return MaterialApp(
      navigatorKey: _navigatorKey, // Assign the global key
      title: 'Recipe App Settings',
      theme: ThemeData(
        colorScheme: customColorScheme,
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Inter', // Using Inter for a modern look
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[850],
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
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: customColorScheme.primary,
            foregroundColor: customColorScheme.onPrimary,
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
            foregroundColor: customColorScheme.primary,
            textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ),
        chipTheme: ChipThemeData(
          selectedColor: customColorScheme.primary.withOpacity(0.2),
          checkmarkColor: customColorScheme.primary,
          labelStyle: const TextStyle(fontSize: 14.0, color: Colors.black87),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          side: BorderSide(color: Colors.grey[300]!, width: 1.0),
          backgroundColor: Colors.white,
        ),
      ),
      home: const SettingsScreen(), // Start with the Settings screen
    );
  }
}

// -----------------------------------------------------------------------------
// Main Settings Screen
// -----------------------------------------------------------------------------
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- Recipe Preferences ---
  final Map<String, List<String>> _preferenceCategories = {
    'Cuisines': [
      'Italian 🍝',
      'Mexican 🌮',
      'Asian 🍣',
      'Indian 🍛',
      'Mediterranean 🥗',
      'American 🍔',
    ],
    'Flavor Profiles': [
      'Spicy 🔥',
      'Sweet 🍬',
      'Savory 🍄',
      'Sour 🍋',
      'Umami 🍜',
      'Mild ☁️',
    ],
    'Preferred Recipe Types': [
      'Quick & Easy ⏱️',
      'Family Meals 👨‍👩‍👧‍👦',
      'Healthy �',
      'Gourmet 🥂',
      'Baking 🍰',
      'Soups 🥣',
      'Salads 🥬',
      'Desserts 🍮',
    ],
    'Dietary Preferences': [
      'Meat Lovers 🥩',
      'Protein Power 💪',
      'Vegetarian 🥦',
      'Vegan 🌱',
      'Gluten-Free 🌾',
      'Keto 🥑',
      'Low-Carb 🍞',
      'Pescatarian 🐟',
      'Dairy-Free 🥛',
      'Nut-Free 🥜',
      'Soy-Free 🌿',
    ],
  };
  final Map<String, List<String>> _selectedPreferences = {
    'Cuisines': [],
    'Flavor Profiles': [],
    'Preferred Recipe Types': [],
    'Dietary Preferences': [],
  };

  // --- Ingredients to Avoid ---
  final TextEditingController _avoidIngredientController =
      TextEditingController();
  final List<String> _avoidIngredients = [];
  final List<String> _commonAllergens = [
    'Dairy',
    'Gluten',
    'Nuts',
    'Eggs',
    'Soy',
    'Fish',
    'Shellfish',
  ];

  @override
  void dispose() {
    _avoidIngredientController.dispose();
    super.dispose();
  }

  // Helper for toggling preferences within categories
  void _togglePreference(String category, String preference) {
    setState(() {
      if (_selectedPreferences[category]!.contains(preference)) {
        _selectedPreferences[category]!.remove(preference);
      } else {
        _selectedPreferences[category]!.add(preference);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$preference preferences updated.')),
      );
    });
  }

  // Helper for adding ingredients to avoid
  void _addAvoidIngredient(String ingredient) {
    final String trimmedIngredient = ingredient.trim();
    if (trimmedIngredient.isNotEmpty &&
        !_avoidIngredients.contains(trimmedIngredient)) {
      setState(() {
        _avoidIngredients.add(trimmedIngredient);
        _avoidIngredientController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added "$trimmedIngredient" to avoid list.')),
      );
    }
  }

  // Helper for removing ingredients to avoid
  void _removeAvoidIngredient(String ingredient) {
    setState(() {
      _avoidIngredients.remove(ingredient);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed "$ingredient" from avoid list.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // Access the themed data

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: theme.scaffoldBackgroundColor,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
      //     onPressed: () {
      //       // Mock navigation: In a real app, this would pop the current route
      //       // For this standalone class, it acts as a mock back button.
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text('Navigating back (mock)')),
      //       );
      //     },
      //   ),
      //   title: Text('Settings', style: theme.textTheme.headlineMedium),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Settings', style: theme.textTheme.headlineMedium)],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Your Recipe Preferences
            _buildSectionTitle(theme, 'Your Recipe Preferences'),
            ..._preferenceCategories.entries.map((entry) {
              final String category = entry.key;
              final List<String> options = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: options.map((option) {
                        final bool isSelected = _selectedPreferences[category]!
                            .contains(option);
                        return FilterChip(
                          label: Text(option),
                          selected: isSelected,
                          onSelected: (selected) =>
                              _togglePreference(category, option),
                          selectedColor: theme.colorScheme.primary.withOpacity(
                            0.2,
                          ),
                          checkmarkColor: theme.colorScheme.primary,
                          labelStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.grey[700],
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.grey[300]!,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 24.0),

            // Section: Ingredients to Avoid
            _buildSectionTitle(theme, 'Ingredients to Avoid'),
            Text(
              'Tell us about allergies or ingredients you just don\'t like. We\'ll filter them out.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            // Pre-populated Common Allergens
            Text(
              'Quick Add Common Allergens:',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: _commonAllergens.map((allergen) {
                final bool isAlreadyAdded = _avoidIngredients.contains(
                  allergen,
                );
                return ActionChip(
                  label: Text(allergen),
                  onPressed: isAlreadyAdded
                      ? null
                      : () => _addAvoidIngredient(allergen),
                  backgroundColor: isAlreadyAdded
                      ? theme.colorScheme.secondary.withOpacity(0.3)
                      : Colors.white,
                  side: BorderSide(
                    color: isAlreadyAdded
                        ? theme.colorScheme.secondary.withOpacity(0.5)
                        : Colors.grey[300]!,
                    width: 1.0,
                  ),
                  labelStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: isAlreadyAdded ? Colors.grey[600] : Colors.grey[800],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24.0),

            // Search Bar with Add Functionality
            TextFormField(
              controller: _avoidIngredientController,
              decoration: InputDecoration(
                hintText: 'Add custom ingredient (e.g., cilantro, mushrooms)',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: theme.colorScheme.primary,
                  ),
                  onPressed: () =>
                      _addAvoidIngredient(_avoidIngredientController.text),
                ),
              ),
              onFieldSubmitted: (value) => _addAvoidIngredient(value),
            ),
            const SizedBox(height: 16.0),

            // Display selected ingredients as deletable chips
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _avoidIngredients.map((ingredient) {
                return Chip(
                  label: Text(ingredient),
                  onDeleted: () => _removeAvoidIngredient(ingredient),
                  deleteIcon: Icon(
                    Icons.cancel,
                    size: 18.0,
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  backgroundColor: theme.colorScheme.secondary.withOpacity(
                    0.15,
                  ),
                  labelStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: theme.colorScheme.secondary,
                      width: 1.0,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40.0),

            // Section: Account Settings
            _buildSectionTitle(theme, 'Account & Security'),
            _buildSettingsListTile(
              theme,
              title: 'Change Email Address',
              icon: Icons.mail_outline,
              onTap: () {
                _navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => const ChangeEmailScreen(),
                  ),
                );
              },
            ),
            _buildSettingsListTile(
              theme,
              title: 'Reset Password',
              icon: Icons.lock_reset,
              onTap: () {
                _navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordFlowScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24.0),

            // Section: Payment Options
            _buildSectionTitle(theme, 'Payment & History'),
            // _buildSettingsListTile(
            //   theme,
            //   title: 'Manage Payment Methods',
            //   icon: Icons.credit_card,
            //   onTap: () {
            //     _navigatorKey.currentState?.push(
            //       MaterialPageRoute(
            //         builder: (context) => const ManagePaymentMethodsScreen(),
            //       ),
            //     );
            //   },
            // ),
            _buildSettingsListTile(
              theme,
              title: 'View Payment History',
              icon: Icons.history,
              onTap: () {
                _navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (context) => const PaymentHistoryScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24.0),

            // Sign Out Button at the bottom
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.logout, color: theme.colorScheme.onPrimary),
                  label: Text(
                    'Sign Out',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Implement actual sign out logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signed out (mock)!')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build section titles consistently
  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: theme.textTheme.headlineMedium?.copyWith(
          color: Colors.grey[800],
          fontSize: 22.0,
        ),
      ),
    );
  }

  // Helper widget to build list tiles for settings options
  Widget _buildSettingsListTile(
    ThemeData theme, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        leading: Icon(icon, color: theme.colorScheme.primary, size: 28),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }
}
