import 'package:shared_preferences/shared_preferences.dart';

void initSharedPreferences(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('dark_theme', true);
}

void getTheme() async {
  final pref = await SharedPreferences.getInstance();
  bool darkTheme = pref.getBool('dark_theme');
  print(darkTheme);
}
