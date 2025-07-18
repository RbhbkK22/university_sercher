import 'package:university_search/feutures/university/data/datasurce/university_datasurce.dart';
import 'package:university_search/feutures/university/domain/entities/university.dart';

abstract class UniversityService {
  Future<List<University>> getUniversities({
    String? name,
    String? country,
    required int offset,
    required int limit,
  });

  
}

class UniversityServiceImpl implements UniversityService {
  final UniversityDatasurce universityDatasurce;

  UniversityServiceImpl({required this.universityDatasurce});

  @override
  Future<List<University>> getUniversities({
    String? name,
    String? country,
    required int offset,
    required int limit,
  }) async {
    return await universityDatasurce.fechUniversities(
      name: name,
      country: country,
      offset: offset,
      limit: limit,
    );
  }
}
