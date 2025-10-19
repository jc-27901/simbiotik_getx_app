import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/meal_entity.dart';

class CartController extends GetxController {
  final RxMap<String, CartItemEntity> _cartItems = <String, CartItemEntity>{}.obs;

  Map<String, CartItemEntity> get cartItems => _cartItems;

  int get totalItems => _cartItems.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => _cartItems.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool isInCart(String mealId) => _cartItems.containsKey(mealId);

  int getQuantity(String mealId) => _cartItems[mealId]?.quantity ?? 0;

  void addToCart(MealEntity meal) {
    if (_cartItems.containsKey(meal.id)) {
      final currentItem = _cartItems[meal.id]!;
      _cartItems[meal.id] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    } else {
      _cartItems[meal.id] = CartItemEntity(meal: meal, quantity: 1);
    }

    Get.snackbar(
      'Added to Cart',
      '${meal.name} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void removeFromCart(String mealId) {
    if (_cartItems.containsKey(mealId)) {
      final currentItem = _cartItems[mealId]!;
      if (currentItem.quantity > 1) {
        _cartItems[mealId] = currentItem.copyWith(quantity: currentItem.quantity - 1);
      } else {
        _cartItems.remove(mealId);
      }
    }
  }

  void increaseQuantity(String mealId) {
    if (_cartItems.containsKey(mealId)) {
      final currentItem = _cartItems[mealId]!;
      _cartItems[mealId] = currentItem.copyWith(quantity: currentItem.quantity + 1);
    }
  }

  void decreaseQuantity(String mealId) {
    removeFromCart(mealId);
  }

  void clearCart() {
    _cartItems.clear();
  }

  Future<void> placeOrder() async {
    if (_cartItems.isEmpty) {
      Get.snackbar(
        'Cart Empty',
        'Please add items to cart before placing order',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Close loading
    Get.back();

    // Show success dialog
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 12),
            Text('Order Placed!'),
          ],
        ),
        content: const Text('Your order has been placed successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to home
              clearCart();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}