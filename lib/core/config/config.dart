import 'dart:convert';

import 'package:flutter/services.dart';

final config = Config();

class Config {
  Config._internal();

  static final Config _instance = Config._internal();

  factory Config() => _instance;

  late Map<String, dynamic> _data;

  bool _isLoaded = false;

  Future<void> load() async {
    if (!_isLoaded) {
      final jsonString = await rootBundle.loadString('assets/config.json');
      _data = json.decode(jsonString);
      _isLoaded = true;
    }
  }

  String get universitiesApiUrl => _data['api_url'] as String;
}
