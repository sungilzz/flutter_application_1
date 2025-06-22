import 'package:flutter/material.dart';

import '../settings/settings_screen.dart';

// -----------------------------------------------------------------------------
// Screen 1: Main Screen - Your Recipe Hub
// -----------------------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    MainScreenContent(),
    // Placeholder widgets for Cart and Saved
    Center(child: Text('Cart')),
    Center(child: Text('Saved')),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Define the vibrant, food-inspired color scheme
    final ColorScheme customColorScheme = ColorScheme.light(
      primary: const Color(0xFFE57373), // A soft red/coral
      primaryContainer: const Color(0xFFFFCDD2),
      secondary: const Color(0xFF81C784), // A vibrant green
      secondaryContainer: const Color(0xFFC8E6C9),
      surface: Colors.white,
      background: Colors.grey[50]!,
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
          fontFamily: 'Inter',
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
        ),
        labelMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
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
        labelStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: BorderSide(color: Colors.grey[300]!, width: 1.0),
        backgroundColor: Colors.white,
      ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Anyone can cook', style: theme.textTheme.headlineMedium),
              IconButton(
                icon: const Icon(Icons.person_outline, size: 28),
                color: Colors.grey[700],
                onPressed: () {
                  // Switch to the Settings tab in the bottom navigation bar
                  final mainScreenState = context
                      .findAncestorStateOfType<_MainScreenState>();
                  if (mainScreenState != null) {
                    mainScreenState.setState(() {
                      mainScreenState._selectedIndex = 3;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: Colors.grey[600],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// Extract the main content of MainScreen to a separate widget
class MainScreenContent extends StatefulWidget {
  @override
  State<MainScreenContent> createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<MainScreenContent> {
  // Mock data for recipe and ingredients
  Map<String, dynamic> _currentRecipe = {
    'title': 'Spicy Garlic Noodles with Shrimp',
    'description':
        'A quick and flavorful noodle dish with a fiery kick, perfect for weeknights.',
    'image':
        'https://recipesfiber.com/wp-content/uploads/2025/06/spicy-garlic-shrimp-noodles-2025-06-21-091049-480x270.webp',
    'cookingTime': '25 min',
    'difficulty': 'Easy',
    'portions': 2,
    'ingredients': [
      {'name': 'Spaghetti/Noodles', 'quantity': '200g'},
      {'name': 'Shrimp (peeled & deveined)', 'quantity': '200g'},
      {'name': 'Garlic (minced)', 'quantity': '6 cloves'},
      {'name': 'Chili Flakes', 'quantity': '1 tsp'},
      {'name': 'Soy Sauce', 'quantity': '2 tbsp'},
      {'name': 'Sesame Oil', 'quantity': '1 tbsp'},
      {'name': 'Broccoli Florets', 'quantity': '1 cup'},
      {'name': 'Lime', 'quantity': '1/2'},
    ],
    'isLiked': false,
    'isSaved': false,
  };

  // State for portions input
  int _portions = 2;

  // State for active filter chips
  final List<String> _selectedFilters = ['Popular on Social'];

  // List of available filter chips
  final List<String> _recipeSourceFilters = [
    'Popular on Social',
    'Near Me',
    'Trending Today',
    'Community Favorites',
    'My Saved',
  ];

  // Controller for search bar
  final TextEditingController _searchController = TextEditingController();

  // Controller for add ingredient input
  final TextEditingController _ingredientInputController =
      TextEditingController();

  // State to control ingredient section expansion
  bool _isIngredientsExpanded = true;

  @override
  void dispose() {
    _searchController.dispose();
    _ingredientInputController.dispose();
    super.dispose();
  }

  // Function to adjust ingredient quantity (mock)
  void _adjustIngredientQuantity(int index, int change) {
    setState(() {
      // For simplicity, directly modifying mock string.
      // In a real app, quantities would be numerical.
      String currentQuantity = _currentRecipe['ingredients'][index]['quantity'];
      if (currentQuantity.contains('g')) {
        int val = int.parse(currentQuantity.replaceAll('g', ''));
        val = (val + change).clamp(50, 500); // Example range
        _currentRecipe['ingredients'][index]['quantity'] =
            '$val'
            'g';
      } else if (currentQuantity.contains('cups')) {
        double val = double.parse(
          currentQuantity.replaceAll('cups', '').trim(),
        );
        val = (val + change * 0.5).clamp(0.5, 4.0); // Example range
        _currentRecipe['ingredients'][index]['quantity'] =
            '${val.toStringAsFixed(1)}'
            ' cups';
      } else {
        // Fallback for non-numeric quantities or just mock adjustment
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Adjusting quantity for ${currentQuantity}')),
        );
      }
    });
  }

  // Function to add a new ingredient (mock)
  void _addIngredient(String ingredientName) {
    if (ingredientName.isNotEmpty &&
        !_currentRecipe['ingredients'].any(
          (item) => item['name'] == ingredientName,
        )) {
      setState(() {
        _currentRecipe['ingredients'].add({
          'name': ingredientName,
          'quantity': 'As needed',
        });
      });
      _searchController.clear(); // Clear input after adding
    }
  }

  // Function to remove an ingredient (mock)
  void _removeIngredient(int index) {
    setState(() {
      _currentRecipe['ingredients'].removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the vibrant, food-inspired color scheme
    final ColorScheme customColorScheme = ColorScheme.light(
      primary: const Color(0xFFE57373), // A soft red/coral
      primaryContainer: const Color(0xFFFFCDD2),
      secondary: const Color(0xFF81C784), // A vibrant green
      secondaryContainer: const Color(0xFFC8E6C9),
      surface: Colors.white,
      background: Colors.grey[50]!,
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
          fontFamily: 'Inter',
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
        ),
        labelMedium: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
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
        labelStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        side: BorderSide(color: Colors.grey[300]!, width: 1.0),
        backgroundColor: Colors.white,
      ),
    );

    return Theme(
      data: theme,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: theme.scaffoldBackgroundColor,
        //   elevation: 0,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text('Anyone can cook', style: theme.textTheme.headlineMedium),
        //       IconButton(
        //         icon: const Icon(Icons.person_outline, size: 28),
        //         color: Colors.grey[700],
        //         onPressed: () {
        //           // Switch to the Settings tab in the bottom navigation bar
        //           final mainScreenState = context
        //               .findAncestorStateOfType<_MainScreenState>();
        //           if (mainScreenState != null) {
        //             mainScreenState.setState(() {
        //               mainScreenState._selectedIndex = 3;
        //             });
        //           }
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Search Section
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText:
                            'What are you cooking today? (e.g., Chicken Curry, Vegan Tacos)',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width:
                                  80, // Adjust width as needed for number input
                              child: TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                controller: TextEditingController(
                                  text: _portions.toString(),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _portions = int.tryParse(val) ?? 1;
                                  });
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Portions',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send),
                              color: theme.colorScheme.primary,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Searching for: ${_searchController.text} for $_portions portions',
                                    ),
                                  ),
                                );
                                // Mock LLM generation logic here
                              },
                            ),
                          ],
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Searching for: $value for $_portions portions',
                            ),
                          ),
                        );
                        // Mock LLM generation logic here
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Recipe Source Filter Chips
                    SizedBox(
                      height: 40, // Height for horizontal scrollable chips
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _recipeSourceFilters.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8.0),
                        itemBuilder: (context, index) {
                          final String filter = _recipeSourceFilters[index];
                          final bool isSelected = _selectedFilters.contains(
                            filter,
                          );
                          return FilterChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedFilters.add(filter);
                                } else {
                                  _selectedFilters.remove(filter);
                                }
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Filter selected: $filter'),
                                ),
                              );
                            },
                            labelStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : Colors.grey[700],
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            selectedColor: theme.colorScheme.primary
                                .withOpacity(0.2),
                            checkmarkColor: theme.colorScheme.primary,
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
                        },
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // LLM-Generated Recipe Result
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16.0),
                            ),
                            child: Image.network(
                              _currentRecipe['image'],
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[600],
                                        size: 50,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _currentRecipe['title'],
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(fontSize: 22),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  _currentRecipe['description'],
                                  style: theme.textTheme.bodyLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _currentRecipe['cookingTime'],
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(
                                      Icons.restaurant_menu,
                                      size: 20,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _currentRecipe['difficulty'],
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        _currentRecipe['isLiked']
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: _currentRecipe['isLiked']
                                            ? Colors.red
                                            : Colors.grey[600],
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _currentRecipe['isLiked'] =
                                              !_currentRecipe['isLiked'];
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              _currentRecipe['isLiked']
                                                  ? 'Liked!'
                                                  : 'Unliked',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        _currentRecipe['isSaved']
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: _currentRecipe['isSaved']
                                            ? theme.colorScheme.primary
                                            : Colors.grey[600],
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _currentRecipe['isSaved'] =
                                              !_currentRecipe['isSaved'];
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              _currentRecipe['isSaved']
                                                  ? 'Recipe Saved!'
                                                  : 'Recipe Unsaved',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ), // Spacer for emphasis on cooking button
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Starting Cooking Mode...',
                                              ),
                                            ),
                                          );
                                          // Navigate to Cooking Mode
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme
                                              .colorScheme
                                              .secondary, // Green accent for action
                                          foregroundColor:
                                              theme.colorScheme.onSecondary,
                                        ),
                                        child: const Text('Start Cooking'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Ingredients Section
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isIngredientsExpanded = !_isIngredientsExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ingredients',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontSize: 22,
                              ),
                            ),
                            Icon(
                              _isIngredientsExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isIngredientsExpanded) ...[
                      const SizedBox(height: 12.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _currentRecipe['ingredients'].length,
                        itemBuilder: (context, index) {
                          final ingredient =
                              _currentRecipe['ingredients'][index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${ingredient['quantity']} ${ingredient['name']}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _adjustIngredientQuantity(index, -1),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    size: 24,
                                    color: Colors.green,
                                  ),
                                  onPressed: () =>
                                      _adjustIngredientQuantity(index, 1),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => _removeIngredient(index),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Add Ingredient Input
                      TextField(
                        controller: _ingredientInputController,
                        decoration: InputDecoration(
                          hintText: 'Add custom ingredient...',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: theme.colorScheme.primary,
                            ),
                            onPressed: () =>
                                _addIngredient(_ingredientInputController.text),
                          ),
                        ),
                        onSubmitted: (value) => _addIngredient(value),
                      ),
                      const SizedBox(height: 16.0),
                      // Adjust Style Button
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          icon: Icon(
                            Icons.tune,
                            color: theme.colorScheme.primary,
                          ),
                          label: Text('Adjust Style'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Opening Adjust Style options...',
                                ),
                              ),
                            );
                            // Navigate to Adjust Style modal/screen
                          },
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      // Add All to Cart Button
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All ingredients added to cart!'),
                            ),
                          );
                          // Logic to add all ingredients to cart
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Add All to Cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
                          foregroundColor: theme.colorScheme.onSecondary,
                          minimumSize: const Size(
                            double.infinity,
                            50,
                          ), // Make button full width
                        ),
                      ),
                    ],
                    const SizedBox(height: 24.0), // Padding before bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
