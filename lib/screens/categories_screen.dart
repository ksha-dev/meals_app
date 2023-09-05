import 'package:flutter/material.dart';

import '/models/meal.dart';
import '/data/dummy_data.dart';
import '/models/category.dart';
import '/screens/meals_screen.dart';
import '/widgets/category_grid_item_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500), lowerBound: 0, upperBound: 1);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 150,
        ),
        children: [
          for (final categories in availableCategories) CategoryGridItemWidget(category: categories, onselectFunction: () => _selectCategory(context, categories)),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate)),
        child: child,
      ),
    );
  }
}
