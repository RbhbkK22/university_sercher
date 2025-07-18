import 'package:university_search/core/network/university_api_client.dart';
import 'package:university_search/feutures/university/data/models/university_model.dart';

abstract class UniversityDatasurce {
  Future<List<UniversityModel>> fechUniversities({
    String? name,
    String? country,
    required int offset,
    required int limit,
  });
}

class UniversityDatasurceImpl implements UniversityDatasurce {
  final UniversityApiClient dio;

  UniversityDatasurceImpl({required this.dio});

  @override
  Future<List<UniversityModel>> fechUniversities({
    String? name,
    String? country,
    required int offset,
    required int limit,
  }) async {
    final queryParameters = {
      'name': name,
      'country': country,
      'offset': offset,
      'limit': limit,
    };

    final response = await dio.get('/search?', queryPrameters: queryParameters);
    if (response.statusCode == 200) {
      final data = response.data as List;

      return data.map((json) => UniversityModel.fromJson(json)).toList();
    } else {
      throw Exception('Ну удалось выполнить запрос к базе');
    }
  }
}
