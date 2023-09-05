import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '/models/meal.dart';
import '/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});
  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText => meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  String get affordabilityText => meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      elevation: 10,
      child: InkWell(
        onTap: () => onSelectMeal(meal),
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(meal.imageUrl), fit: BoxFit.cover, height: 200, width: double.infinity),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Hero(tag: meal.title, child: Text(meal.title, maxLines: 2, textAlign: TextAlign.center, softWrap: true, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min'),
                          const SizedBox(width: 12),
                          MealItemTrait(icon: Icons.work, label: complexityText),
                          const SizedBox(width: 12),
                          MealItemTrait(icon: Icons.attach_money, label: affordabilityText),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
