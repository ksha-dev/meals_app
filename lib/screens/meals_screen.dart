import 'package:flutter/material.dart';
import '/models/meal.dart';
import '/screens/meal_details_screen.dart';
import '/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals, required this.onToggleFavourite});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourite;

  void selectMeal(Meal meal, BuildContext context) => Navigator.push(context, MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal, onToggleFavourite: onToggleFavourite)));

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(meal: meals[index], onSelectMeal: (meal) => selectMeal(meal, context)),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Uh oh... nothing here', style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(height: 10),
            Text("Try selecting a different category!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground))
          ],
        ),
      );
    }
    if (title == null) return content;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
