import 'package:flutter/material.dart';
import 'package:university_search/feutures/university/domain/entities/university.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentUniversity extends StatefulWidget {
  final University university;

  const CurrentUniversity({super.key, required this.university});

  @override
  State<CurrentUniversity> createState() => _CurrentUniversityState();
}

class _CurrentUniversityState extends State<CurrentUniversity> {
  Future<void> _lunchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Не удалось открыть ссылку')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final university = widget.university;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        widget.university.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SelectableText(
                        'Страна: ${widget.university.country}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text('Ссылки:', style: TextStyle(fontSize: 16)),
                      if (university.webPages != null &&
                          university.webPages!.isNotEmpty)
                        ...university.webPages!.map(
                          (url) => InkWell(
                            onTap: () => _lunchUrl(url),
                            child: Text(
                              url,
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
