import 'package:get/get.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repositories/meal_repository.dart';

class MealController extends GetxController {
  final MealRepository _mealRepository;

  MealController(this._mealRepository);

  final RxList<CategoryEntity> _categories = <CategoryEntity>[].obs;
  final RxList<MealEntity> _meals = <MealEntity>[].obs;
  final RxInt _selectedCategoryIndex = 0.obs;
  final RxBool _isLoadingCategories = false.obs;
  final RxBool _isLoadingMeals = false.obs;
  final RxString _errorMessage = ''.obs;

  List<CategoryEntity> get categories => _categories;
  List<MealEntity> get meals => _meals;
  int get selectedCategoryIndex => _selectedCategoryIndex.value;
  bool get isLoadingCategories => _isLoadingCategories.value;
  bool get isLoadingMeals => _isLoadingMeals.value;
  String get errorMessage => _errorMessage.value;

  String get selectedCategory =>
      _categories.isNotEmpty ? _categories[_selectedCategoryIndex.value].name : '';

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      _isLoadingCategories.value = true;
      _errorMessage.value = '';

      final categories = await _mealRepository.getCategories();
      _categories.value = categories;

      if (categories.isNotEmpty) {
        fetchMealsByCategory(categories[0].name);
      }
    } catch (e) {
      _errorMessage.value = 'Failed to load categories';
      Get.snackbar(
        'Error',
        'Failed to load categories: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoadingCategories.value = false;
    }
  }

  Future<void> fetchMealsByCategory(String category) async {
    try {
      _isLoadingMeals.value = true;
      _errorMessage.value = '';

      final meals = await _mealRepository.getMealsByCategory(category);
      _meals.value = meals;
    } catch (e) {
      _errorMessage.value = 'Failed to load meals';
      Get.snackbar(
        'Error',
        'Failed to load meals: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoadingMeals.value = false;
    }
  }

  void selectCategory(int index) async {
    if (index != _selectedCategoryIndex.value && index < _categories.length) {
      _selectedCategoryIndex.value = index;
     await fetchMealsByCategory(_categories[index].name);
    }
  }

  void retry() {
    if (_categories.isEmpty) {
      fetchCategories();
    } else {
      fetchMealsByCategory(selectedCategory);
    }
  }
}