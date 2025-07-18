import 'package:university_search/feutures/university/domain/entities/university.dart';

abstract class UniversityState {}

class UniversityInitial extends UniversityState {}

class UniversityLoading extends UniversityState {}

class UniversityLoaded extends UniversityState {
  final List<University> universities;
  final bool hasReachedMax;

  UniversityLoaded({required this.universities, required this.hasReachedMax});

  UniversityLoaded copyWith(
    List<University>? universities,
    bool? hasReachedMax,
  ) {
    return UniversityLoaded(
      universities: universities ?? this.universities,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class UniversityError extends UniversityState {
  final String message;

  UniversityError(this.message);
}
