class MealEntity {
  final String id;
  final String name;
  final String thumbnail;
  final double price;
  final double calories;

  MealEntity({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.price = 50,
    this.calories = 10,
  });
}
