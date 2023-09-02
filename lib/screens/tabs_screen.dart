import 'package:flutter/material.dart';

import '/data/dummy_data.dart';
import '/models/meal.dart';
import '/screens/filters_screen.dart';
import '/screens/categories_screen.dart';
import '/screens/meals_screen.dart';
import '/widgets/main_drawer.dart';

const Map<Filter, bool> kInitialFilters = {Filter.glutenFree: false, Filter.lactoseFree: false, Filter.vegetarian: false, Filter.vegan: false};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = {Filter.glutenFree: false, Filter.lactoseFree: false, Filter.vegetarian: false, Filter.vegan: false};

  void _selectPage(int index) => setState(() => _selectedPageIndex = index);
  void _toggleMealFavouriteStatus(Meal meal) {
    if (_favouriteMeals.contains(meal)) {
      _favouriteMeals.remove(meal);
      _showInfoMessage('${meal.title} has been removed from your favourites list');
    } else {
      _favouriteMeals.add(meal);
      _showInfoMessage('${meal.title} has been added to your favourites list');
    }
  }

  void _showInfoMessage(String message) => {ScaffoldMessenger.of(context).clearSnackBars(), ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)))};
  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters)));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((Meal meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) return false;
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(onToggleFavourite: _toggleMealFavouriteStatus, availableMeals: availableMeals);
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(meals: _favouriteMeals, title: null, onToggleFavourite: _toggleMealFavouriteStatus);
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
