import 'package:simbiotik_getx_app/domain/entities/category_entity.dart';
import 'package:simbiotik_getx_app/domain/entities/meal_entity.dart';

abstract class MealRepository {
  Future<List<CategoryEntity>> getCategories();
  Future<List<MealEntity>> getMealsByCategory(String category);
}
