import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/onboarding/ingredients_to_avoid_screen.dart';
import 'package:flutter_application_1/onboarding/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -----------------------------------------------------------------------------
// Screen 2: Flavor & Type Preferences (Initial Broad Strokes)
// -----------------------------------------------------------------------------
class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _FlavorTypePreferencesScreenState();
}

class _FlavorTypePreferencesScreenState extends State<PreferenceScreen> {
  // State to hold selected preferences
  final List<String> _selectedPreferences = [];

  // Data for different categories of chips (now with value/label pairs)
  final List<Map<String, dynamic>> _preferenceCategories = [
    {
      'key': 'flavorProfiles',
      'label': 'preference.category.FlavorProfiles',
      'options': [
        {'value': 'spicy', 'label': 'preference.option.spicy'},
        {'value': 'sweet', 'label': 'preference.option.sweet'},
        {'value': 'savory', 'label': 'preference.option.savory'},
        {'value': 'sour', 'label': 'preference.option.sour'},
        {'value': 'umami', 'label': 'preference.option.umami'},
        {'value': 'mild', 'label': 'preference.option.mild'},
      ],
    },
    {
      'key': 'cuisines',
      'label': 'preference.category.Cuisines',
      'options': [
        {'value': 'italian', 'label': 'preference.option.italian'},
        {'value': 'mexican', 'label': 'preference.option.mexican'},
        {'value': 'asian', 'label': 'preference.option.asian'},
        {'value': 'indian', 'label': 'preference.option.indian'},
        {'value': 'mediterranean', 'label': 'preference.option.mediterranean'},
        {'value': 'american', 'label': 'preference.option.american'},
      ],
    },
    {
      'key': 'recipeTypes',
      'label': 'preference.category.RecipeTypes',
      'options': [
        {'value': 'quick_easy', 'label': 'preference.option.quick_easy'},
        {'value': 'family_meals', 'label': 'preference.option.family_meals'},
        {'value': 'healthy', 'label': 'preference.option.healthy'},
        {'value': 'gourmet', 'label': 'preference.option.gourmet'},
        {'value': 'baking', 'label': 'preference.option.baking'},
        {'value': 'soups', 'label': 'preference.option.soups'},
        {'value': 'salads', 'label': 'preference.option.salads'},
        {'value': 'desserts', 'label': 'preference.option.desserts'},
      ],
    },
    {
      'key': 'dietaryPreferences',
      'label': 'preference.category.DietaryPreferences',
      'options': [
        {'value': 'meat_lovers', 'label': 'preference.option.meat_lovers'},
        {'value': 'protein_power', 'label': 'preference.option.protein_power'},
        {'value': 'vegetarian', 'label': 'preference.option.vegetarian'},
        {'value': 'vegan', 'label': 'preference.option.vegan'},
        {'value': 'gluten_free', 'label': 'preference.option.gluten_free'},
        {'value': 'keto', 'label': 'preference.option.keto'},
        {'value': 'low_carb', 'label': 'preference.option.low_carb'},
        {'value': 'pescatarian', 'label': 'preference.option.pescatarian'},
        {'value': 'dairy_free', 'label': 'preference.option.dairy_free'},
        {'value': 'nut_free', 'label': 'preference.option.nut_free'},
        {'value': 'soy_free', 'label': 'preference.option.soy_free'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedPreferences();
  }

  Future<void> _loadSelectedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedPrefs = prefs.getStringList(
      'selected_preferences',
    );
    if (savedPrefs != null) {
      setState(() {
        _selectedPreferences.clear();
        _selectedPreferences.addAll(savedPrefs);
      });
    }
  }

  Future<void> _saveSelectedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selected_preferences', _selectedPreferences);
  }

  // Function to handle chip selection/deselection
  void _togglePreference(String preference) {
    setState(() {
      if (_selectedPreferences.contains(preference)) {
        _selectedPreferences.remove(preference);
      } else {
        _selectedPreferences.add(preference);
      }
    });
    _saveSelectedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // Remove the local Theme widget and use the app-wide theme instead
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(
          context,
        ).scaffoldBackgroundColor, // Use themed background color
        elevation: 0, // Flat app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              (route) => false,
            );
          },
        ),
        title: Text(
          AppLocalizations.of(context)?.translate('preference.title') ??
              'What you love?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.translate('preference.headline') ??
                  'What flavors and types do you love?',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 8.0),
            Text(
              AppLocalizations.of(context)?.translate('preference.subtitle') ??
                  'Select all that apply. You can change these anytime.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32.0),

            // Iterate through categories and build chip sections
            ..._preferenceCategories.map((category) {
              final String categoryLabelKey = category['label'];
              final List options = category['options'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(
                            context,
                          )?.translate(categoryLabelKey) ??
                          categoryLabelKey,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: Colors.grey[700], fontSize: 20.0),
                    ),
                    const SizedBox(height: 16.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: options.map<Widget>((option) {
                        final bool isSelected = _selectedPreferences.contains(
                          option['value'],
                        );
                        return FilterChip(
                          label: Text(
                            AppLocalizations.of(
                                  context,
                                )?.translate(option['label']) ??
                                option['label'],
                          ),
                          selected: isSelected,
                          onSelected: (selected) =>
                              _togglePreference(option['value']),
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.2),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                          labelStyle: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[700],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[300]!,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors.white,
                          elevation: isSelected ? 2 : 0,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),

            const SizedBox(height: 24.0), // Spacing before the button
            // Next Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _saveSelectedPreferences();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const IngredientsToAvoidScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFE57373,
                  ), // Match welcome screen
                  foregroundColor: Colors.white, // Match welcome screen
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
                    AppLocalizations.of(
                          context,
                        )?.translate('preference.next') ??
                        'Next',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Spacing at the bottom
            SizedBox(height: 40.0), // Extra space at the very bottom
          ],
        ),
      ),
    );
  }
}
