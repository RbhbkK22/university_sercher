import 'dart:async';

import 'package:university_search/feutures/university/data/service/university_service.dart';
import 'package:university_search/feutures/university/presentation/bloc/university_event.dart';
import 'package:university_search/feutures/university/presentation/bloc/university_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  final UniversityService universityService;
  static const limit = 20;
  int offset = 0;
  bool isFetching = false;

  String? universityName;
  String? universityCountry;

  UniversityBloc({required this.universityService})
    : super(UniversityInitial()) {
    on<UniversityEventFetch>(_fethUniversities);
    on<UniversityEventLoadMore>(_fethMore);
  }

  FutureOr<void> _fethUniversities(
    UniversityEventFetch event,
    Emitter<UniversityState> emit,
  ) async {
    if (isFetching) return;

    isFetching = true;
    offset = 0;
    universityName = event.name;
    universityCountry = event.country;
    emit(UniversityLoading());
    try {
      final universities = await universityService.getUniversities(
        name: universityName,
        country: universityCountry,
        offset: offset,
        limit: limit,
      );

      offset += universities.length;
      emit(
        UniversityLoaded(
          universities: universities,
          hasReachedMax: universities.length < limit,
        ),
      );
    } catch (e) {
      emit(UniversityError(e.toString()));
    } finally {
      isFetching = false;
    }
  }

  FutureOr<void> _fethMore(
    UniversityEventLoadMore event,
    Emitter<UniversityState> emit,
  ) async {
    if (isFetching) return;
    if (state is UniversityLoaded) {
      final loadedState = state as UniversityLoaded;
      if (loadedState.hasReachedMax) return;
      isFetching = true;
      try {
        final universities = await universityService.getUniversities(
          offset: offset,
          limit: limit,
          name: universityName,
          country: universityCountry,
        );
        offset += universities.length;
        final allUniversities = List.of(loadedState.universities)
          ..addAll(universities);
        emit(
          UniversityLoaded(
            universities: allUniversities,
            hasReachedMax: universities.length < limit,
          ),
        );
      } catch (e) {
        emit(UniversityError(e.toString()));
      } finally {
        isFetching = false;
      }
    }
  }
}
