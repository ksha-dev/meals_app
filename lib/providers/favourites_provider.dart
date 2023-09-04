import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleFavouriteMealStatus(Meal meal) {
    state = state.contains(meal) ? state.where((m) => m.id != meal.id).toList() : [...state, meal];
    return state.contains(meal);
  }
}

final favouriteProvider = StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) => FavouriteMealsNotifier());
