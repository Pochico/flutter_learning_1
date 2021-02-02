import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/utils/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
  // SettingsScreen({Key key, this.animationValue}) : super(key: key);
  // final double animationValue;
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool isDarkTheme;
  bool isJulenTonto;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        upperBound: 0.12);

    themeIsDark();

    // julenIsTonto();
    WidgetsBinding.instance.addPostFrameCallback((_) => {setState(() => {})});
    super.initState();
  }

  void themeIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = prefs.getBool('is_dark_theme');
    });

    isDarkTheme == true
        ? animationController.forward()
        : animationController.reverse();
    setTheme();
  }

  // void julenIsTonto() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (isJulenTonto == null) {
  //     julenNoEsTontoPreference(true);
  //   }
  //   setState(() {
  //     isJulenTonto = prefs.getBool('is_julen_tonto');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              isDarkTheme == true
                  ? 'Dark Mode: Enabled'
                  : 'Dark Mode: Disabled',
              style: TextStyle(
                  color: secondaryColor,
                  decoration: TextDecoration.none,
                  fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                if (isDarkTheme) {
                  animationController.reverse();
                  themeSharedPreferences(false);
                  themeIsDark();
                } else {
                  animationController.forward();
                  themeSharedPreferences(true);
                  themeIsDark();
                }
              },
              child: Lottie.asset(
                'assets/animations/switch.json',
                controller: animationController,
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     julenIsTonto();
            //   },
            //   child: Container(
            //     height: 200,
            //     width: 200,
            //     decoration: BoxDecoration(color: Colors.red),
            //   ),
            // ),
            // Text(isJulenTonto ? 'julen no es tonto' : 'Hola qué tal')
          ]),
        ),
      ),
    );
  }
}
