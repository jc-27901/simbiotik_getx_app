import 'package:simbiotik_getx_app/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json['strCategory'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'strCategory': name};
  }

  CategoryEntity toEntity() {
    return CategoryEntity(name: name);
  }
}
