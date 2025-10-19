import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simbiotik_getx_app/presentation/controllers/auth_controllers.dart';
import '../controllers/meal_controller.dart';
import '../widgets/app_drawer.dart';
import '../widgets/category_tabs.dart';
import '../widgets/meal_card.dart';
import '../widgets/cart_badge.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final mealController = Get.find<MealController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals'),
        elevation: 2,
        actions: [
          const CartBadge(),
          Obx(() {
            final user = authController.user;
            if (user?.photoUrl != null) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(user!.photoUrl!),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const CategoryTabs(),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (mealController.isLoadingMeals && mealController.meals.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (mealController.errorMessage.isNotEmpty && mealController.meals.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        mealController.errorMessage,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: mealController.retry,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (mealController.meals.isEmpty) {
                return const Center(
                  child: Text(
                    'No meals available',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => mealController.fetchMealsByCategory(
                  mealController.selectedCategory,
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 300
                  ),
                  itemCount: mealController.meals.length,
                  itemBuilder: (context, index) {
                    final meal = mealController.meals[index];
                    return MealCard(meal: meal);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}