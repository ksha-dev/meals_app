import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(meal.imageUrl, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text('Ingridients', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            for (final ingrident in meal.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(ingrident, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground)),
              ),
            const SizedBox(height: 24),
            Text('Steps', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            for (final steps in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(steps, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onBackground), textAlign: TextAlign.center),
              ),
          ],
        ),
      ),
    );
  }
}
