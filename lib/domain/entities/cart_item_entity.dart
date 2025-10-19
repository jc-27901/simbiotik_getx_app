import 'meal_entity.dart';

class CartItemEntity {
  final MealEntity meal;
  final int quantity;

  CartItemEntity({
    required this.meal,
    required this.quantity,
  });

  double get totalPrice => meal.price * quantity;

  CartItemEntity copyWith({
    MealEntity? meal,
    int? quantity,
  }) {
    return CartItemEntity(
      meal: meal ?? this.meal,
      quantity: quantity ?? this.quantity,
    );
  }
}