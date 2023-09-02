import 'package:flutter/material.dart';

import '/models/category.dart';

class CategoryGridItemWidget extends StatelessWidget {
  const CategoryGridItemWidget({required this.category, required this.onselectFunction, super.key});

  final Category category;
  final void Function() onselectFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onselectFunction(),
      splashColor: category.color,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [category.color.withOpacity(0.55), category.color.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
