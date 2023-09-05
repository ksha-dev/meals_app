import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';

import '/models/meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteProvider);

    final isFavourite = favouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          onPressed: () {
            final bool wasAdded = ref.read(favouriteProvider.notifier).toggleFavouriteMealStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${meal.title} has been ${wasAdded ? 'added to' : 'removed from'} your favourites list')));
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Icon(isFavourite ? Icons.star : Icons.star_border, key: ValueKey(isFavourite)),
            transitionBuilder: (child, animation) => RotationTransition(turns: Tween(begin: 0.6, end: 1.0).animate(animation), child: child),
          ),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: meal.id, child: Image.network(meal.imageUrl, width: double.infinity, fit: BoxFit.cover)),
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
