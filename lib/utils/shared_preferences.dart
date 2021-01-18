import 'package:shared_preferences/shared_preferences.dart';

void initSharedPreferences(bool themeValue) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('dark_theme', themeValue);
  // await prefs.setBool('animation_controller', animationValue);
}

// Future<bool> getSwitchAnimationController() async {
//   final prefs = await SharedPreferences.getInstance();
//   final switchAnimationController = prefs.getBool('animation_controller');
//   return switchAnimationController;
// }

// void getTheme() async {
//   final pref = await SharedPreferences.getInstance();
//   bool darkTheme = pref.getBool('dark_theme');
//   print(darkTheme);
// }
