
import 'package:go_router/go_router.dart';
import 'package:university_search/feutures/university/domain/entities/university.dart';
import 'package:university_search/feutures/university/presentation/current_university.dart';
import 'package:university_search/feutures/university/presentation/universities_screen.dart';


class AppRouter {
  final router = GoRouter(
    initialLocation: '/universities',
    routes: [
      GoRoute(
        path: '/universities',
        builder: (context, state) {
          return UniversitiesScreen();
        },
      ),
      GoRoute(path: '/current_university', builder: (context, state) {
        final University university = state.extra as University;
        return CurrentUniversity(university: university);
      },)
    ],
  );
}
