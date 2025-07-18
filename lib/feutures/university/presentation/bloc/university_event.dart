abstract class UniversityEvent {}

class UniversityEventFetch extends UniversityEvent {
  final String? name;
  final String? country;

  UniversityEventFetch({required this.name, required this.country});
}

class UniversityEventLoadMore extends UniversityEvent {}
