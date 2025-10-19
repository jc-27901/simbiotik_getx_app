import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/meal_entity.dart';
import '../controllers/cart_controller.dart';

class QuantityButton extends StatelessWidget {
  final MealEntity meal;

  const QuantityButton({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final quantity = cartController.getQuantity(meal.id);
      final isInCart = quantity > 0;

      if (!isInCart) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => cartController.addToCart(meal),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => cartController.decreaseQuantity(meal.id),
              icon: const Icon(Icons.remove, size: 18),
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
            Text(
              '$quantity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () => cartController.increaseQuantity(meal.id),
              icon: const Icon(Icons.add, size: 18),
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ),
      );
    });
  }
}