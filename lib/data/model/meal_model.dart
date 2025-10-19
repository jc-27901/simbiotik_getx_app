import 'package:simbiotik_getx_app/domain/entities/meal_entity.dart';

class MealModel extends MealEntity {
  MealModel({
    required super.id,
    required super.name,
    required super.thumbnail,
    super.price,
    super.calories,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      thumbnail: json['strMealThumb'] as String,
      price: 50.0,
      calories: 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {'idMeal': id, 'strMeal': name, 'strMealThumb': thumbnail};
  }

  MealEntity toEntity() {
    return MealEntity(
      id: id,
      name: name,
      thumbnail: thumbnail,
      price: price,
      calories: calories,
    );
  }
}
