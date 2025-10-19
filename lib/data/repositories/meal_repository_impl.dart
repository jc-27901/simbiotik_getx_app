import 'package:simbiotik_getx_app/data/dataSource/api_client.dart';
import 'package:simbiotik_getx_app/data/model/category_model.dart';
import 'package:simbiotik_getx_app/data/model/meal_model.dart';
import 'package:simbiotik_getx_app/domain/entities/category_entity.dart';
import 'package:simbiotik_getx_app/domain/entities/meal_entity.dart';
import 'package:simbiotik_getx_app/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final ApiClient _apiClient;

  MealRepositoryImpl({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final response = await _apiClient.get('/list.php?c=list');

      final List<dynamic> mealsJson = response['meals'] as List<dynamic>;

      return mealsJson
          .map(
            (json) =>
                CategoryModel.fromJson(json as Map<String, dynamic>).toEntity(),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<List<MealEntity>> getMealsByCategory(String category) async {
    try {
      final response = await _apiClient.get('/filter.php?c=$category');

      final List<dynamic>? mealsJson = response['meals'] as List<dynamic>?;

      if (mealsJson == null || mealsJson.isEmpty) {
        return [];
      }

      return mealsJson
          .map(
            (json) =>
                MealModel.fromJson(json as Map<String, dynamic>).toEntity(),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch meals: $e');
    }
  }
}
