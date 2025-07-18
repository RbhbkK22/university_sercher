import 'package:university_search/feutures/university/domain/entities/university.dart';

class UniversityModel extends University {
  UniversityModel({
    required super.name,
    required super.country,
    required super.webPages,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      webPages: json['web_pages'] ?? [],
    );
  }
}
