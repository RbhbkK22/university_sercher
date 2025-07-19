import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:university_search/feutures/university/presentation/bloc/university_bloc.dart';
import 'package:university_search/feutures/university/presentation/bloc/university_event.dart';
import 'package:university_search/feutures/university/presentation/bloc/university_state.dart';
import 'package:university_search/feutures/university/widgets/country_alert_dialog.dart';
import 'package:university_search/feutures/university/widgets/university_text_fields.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final nameController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  late UniversityBloc universityBloc;
  String? country = '';

  @override
  void initState() {
    super.initState();
    universityBloc = context.read<UniversityBloc>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        universityBloc.add(UniversityEventLoadMore());
      }
    });
    universityBloc.add(UniversityEventFetch(name: null, country: null));
  }

  @override
  void dispose() {
    scrollController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                NameTextField(
                  controller: nameController,
                  onSubmitted: (value) {
                    universityBloc.add(
                      UniversityEventFetch(
                        name: nameController.text,
                        country: country,
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    country = await showDialog(
                      context: context,
                      builder: (context) {
                        return CountryAlertDialog();
                      },
                    );
                    universityBloc.add(
                      UniversityEventFetch(
                        name: nameController.text,
                        country: country,
                      ),
                    );
                  },

                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Выбрать страну',
                    style: TextStyle(color: Color(0xFF0084FF), fontSize: 14),
                  ),
                ),
              ],
            ),

            BlocBuilder<UniversityBloc, UniversityState>(
              builder: (context, state) {
                if (state is UniversityInitial || state is UniversityLoading) {
                  return CircularProgressIndicator();
                } else if (state is UniversityError) {
                  return Center(child: Text(state.message));
                } else if (state is UniversityLoaded) {
                  if (state.universities.isEmpty) {
                    return Center(child: Text('Таких универов нет'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.hasReachedMax
                          ? state.universities.length
                          : state.universities.length + 1,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        if (index >= state.universities.length) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final university = state.universities[index];
                        return ListTile(
                          onTap: () {
                            context.push(
                              '/current_university',
                              extra: university,
                            );
                          },
                          title: Text(university.name),
                          subtitle: Text(university.country),
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
