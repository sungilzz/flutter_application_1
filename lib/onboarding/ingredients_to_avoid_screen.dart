import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/onboarding/preference_screen.dart';

// -----------------------------------------------------------------------------
// Screen 3: Ingredients to Avoid (Allergies & Dislikes)
// -----------------------------------------------------------------------------
class IngredientsToAvoidScreen extends StatefulWidget {
  const IngredientsToAvoidScreen({super.key});

  @override
  State<IngredientsToAvoidScreen> createState() =>
      _IngredientsToAvoidScreenState();
}

class _IngredientsToAvoidScreenState extends State<IngredientsToAvoidScreen> {
  // Controller for the ingredient input field
  final TextEditingController _ingredientInputController =
      TextEditingController();

  // List to hold ingredients selected to be avoided
  final List<String> _avoidIngredients = [];

  // List of common allergens for quick selection
  final List<String> _commonAllergens = [
    'ingredient.dairy',
    'ingredient.gluten',
    'ingredient.nuts',
    'ingredient.eggs',
    'ingredient.soy',
    'ingredient.fish',
    'ingredient.shellfish',
  ];

  @override
  void dispose() {
    _ingredientInputController.dispose();
    super.dispose();
  }

  // Function to add an ingredient to the avoid list
  void _addAvoidIngredient(String ingredient) {
    final String trimmedIngredient = ingredient.trim();
    if (trimmedIngredient.isNotEmpty &&
        !_avoidIngredients.contains(trimmedIngredient)) {
      setState(() {
        _avoidIngredients.add(trimmedIngredient);
        _ingredientInputController.clear(); // Clear input after adding
      });
    }
  }

  // Function to remove an ingredient from the avoid list
  void _removeAvoidIngredient(String ingredient) {
    setState(() {
      _avoidIngredients.remove(ingredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the vibrant, food-inspired color scheme
    // In a full app, this should ideally be part of the MaterialApp's theme.
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

    // Apply the custom color scheme and text theme to the current context's theme
    final ThemeData theme = Theme.of(context).copyWith(
      colorScheme: customColorScheme,
      scaffoldBackgroundColor: Colors.grey[50],
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[850],
          fontFamily: 'Inter', // Using Inter for a modern look
        ),
        headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          fontFamily: 'Inter',
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          color: Colors.grey[700],
          fontFamily: 'Inter',
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          color: Colors.grey[600],
          fontFamily: 'Inter',
        ),
        labelLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ), // For buttons
        labelMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
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
          borderSide: BorderSide(color: customColorScheme.primary, width: 2.0),
        ),
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: customColorScheme.primary, // Primary button color
          foregroundColor: customColorScheme.onPrimary, // Text color on primary
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
    );

    return Theme(
      data: theme, // Apply the custom theme data
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const PreferenceScreen(),
                ),
                (route) => false,
              );
            },
          ),
          title: Text(
            AppLocalizations.of(
                  context,
                )?.translate('ingredientsToAvoid.title') ??
                'Any ingredients to avoid?',
            style: theme.textTheme.headlineMedium,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate('ingredientsToAvoid.headline') ??
                    'Tell us about allergies or ingredients you just don\'t like. We\'ll filter them out.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32.0),

              // Section: Pre-populated Common Allergens
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate('ingredientsToAvoid.commonAllergens') ??
                    'Common Allergens (Quick Add)',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: _commonAllergens.map((allergenKey) {
                  final String allergen =
                      AppLocalizations.of(context)?.translate(allergenKey) ??
                      allergenKey;
                  final bool isAlreadyAdded = _avoidIngredients.contains(
                    allergen,
                  );
                  return ActionChip(
                    label: Text(allergen),
                    onPressed: isAlreadyAdded
                        ? null
                        : () => _addAvoidIngredient(allergen),
                    // Disable if already added
                    backgroundColor: isAlreadyAdded
                        ? theme.colorScheme.secondary.withOpacity(
                            0.3,
                          ) // Faded if added
                        : Colors.white,
                    side: BorderSide(
                      color: isAlreadyAdded
                          ? theme.colorScheme.secondary.withOpacity(0.5)
                          : Colors.grey[300]!,
                      width: 1.0,
                    ),
                    labelStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: isAlreadyAdded
                          ? Colors.grey[600]
                          : Colors.grey[800],
                      fontWeight: FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 1,
                  );
                }).toList(),
              ),
              const SizedBox(height: 40.0),

              // Section: Search Bar with Auto-suggestions + Chip/Tag Selection
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate('ingredientsToAvoid.addOther') ??
                    'Add other ingredients',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.grey[700],
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ingredientInputController,
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(
                        context,
                      )?.translate('ingredientsToAvoid.inputHint') ??
                      'Type an ingredient to avoid (e.g., cilantro, mushrooms)',
                  // prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: theme.colorScheme.primary,
                    ),
                    onPressed: () =>
                        _addAvoidIngredient(_ingredientInputController.text),
                  ),
                ),
                onFieldSubmitted: (value) =>
                    _addAvoidIngredient(value), // Add on pressing Enter
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40.0),

              // Finish Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Mock action for finishing personalization
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          (AppLocalizations.of(context)?.translate(
                                    'ingredientsToAvoid.finishMessage',
                                  ) ??
                                  'Personalization complete!\nAvoiding: ${_avoidIngredients.join(', ')}')
                              .replaceFirst(
                                '{ingredients}',
                                _avoidIngredients.join(', '),
                              ),
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    // In a real app, this would navigate to the main recipe feed
                  },
                  child: Text(
                    AppLocalizations.of(
                          context,
                        )?.translate('ingredientsToAvoid.finish') ??
                        'Finish',
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
