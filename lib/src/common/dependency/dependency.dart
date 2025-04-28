import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_service.dart';

class AppDepenency {
  String locale;
  bool theme;
  final SharedPreferences sharedPreferences;
  final ApiService apiService;

  AppDepenency({
    required this.locale,
    required this.theme,
    required this.sharedPreferences,
    required this.apiService,
  });
}