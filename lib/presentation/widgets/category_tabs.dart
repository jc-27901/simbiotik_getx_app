import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/meal_controller.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final mealController = Get.find<MealController>();

    return Obx(() {
      if (mealController.isLoadingCategories) {
        return const SizedBox(
          height: 50,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (mealController.categories.isEmpty) {
        return const SizedBox.shrink();
      }

      return SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: mealController.categories.length,
          itemBuilder: (context, index) {
            final category = mealController.categories[index];


            return Obx(() {
              final isSelected = index == mealController.selectedCategoryIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category.name),
                    selected: isSelected,
                    onSelected: (_) => mealController.selectCategory(index),
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                );
              }
            );
          },
        ),
      );
    });
  }
}