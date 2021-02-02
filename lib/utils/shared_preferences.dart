import 'package:nasa_app/constant/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void themeSharedPreferences(bool themeValue) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_dark_theme', themeValue);
  setTheme();
}

void julenNoEsTontoPreference(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_julen_tonto', value);
}
