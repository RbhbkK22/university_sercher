import 'package:flutter/material.dart';

import 'package:university_search/feutures/university/widgets/search_text_field.dart';

class CountryAlertDialog extends StatelessWidget {
  const CountryAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final countryController = TextEditingController();

    return AlertDialog(
      title: Text('Напишите странну'),
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 500,
        child: SearchTextField(
          controller: countryController,
          onSubmitted: (value) {},
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Отмена', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            final country = countryController.text;
            Navigator.of(context).pop(country.isEmpty ? null : country);
          },
          child: Text('Применить', style: TextStyle(color: Color(0xFF0084FF))),
        ),
      ],
    );
  }
}
