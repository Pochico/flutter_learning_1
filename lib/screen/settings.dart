import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/utils/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animationController.value;
    super.initState();
  }

  bool darkTheme;
  bool futureToBoolDarkTheme() {
    getTheme().then((value) {
      darkTheme = value;
    });
    print(darkTheme);
    return darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    futureToBoolDarkTheme();
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Enable Dark Mode',
              style: TextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.none,
                  fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                initSharedPreferences(!darkTheme);
                animationController.value == 1
                    ? animationController.reverse()
                    : animationController.forward();
                print(animationController.value);
              },
              child: Lottie.asset(
                'assets/animations/switch.json',
                controller: animationController,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
