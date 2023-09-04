import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';

import '/models/meal.dart';
import '/providers/filters_provider.dart';
import '/screens/filters_screen.dart';
import '/screens/categories_screen.dart';
import '/screens/meals_screen.dart';
import '/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  // ConsumerWidget for stateless widget
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) => setState(() => _selectedPageIndex = index);

  void _setScreen(String identifier) {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider); // provider that depends on other providers

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
        title: null,
      );
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourites'),
        ],
        onTap: (index) => _selectPage(index),
      ),
    );
  }
}
