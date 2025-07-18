import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_search/core/config/config.dart';
import 'package:university_search/core/network/university_api_client.dart';
import 'package:university_search/core/routing/app_router.dart';
import 'package:university_search/feutures/university/data/datasurce/university_datasurce.dart';
import 'package:university_search/feutures/university/data/service/university_service.dart';
import 'package:university_search/feutures/university/presentation/bloc/university_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Config().load();

  final universityClient = UniversityApiClient();
  final universityDatasurce = UniversityDatasurceImpl(dio: universityClient);
  final universityService = UniversityServiceImpl(
    universityDatasurce: universityDatasurce,
  );


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UniversityBloc(universityService: universityService),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}
