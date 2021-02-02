import 'package:flutter/material.dart';
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
  bool darkTheme;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
        upperBound: 0.5);
    futureToBoolDarkTheme();
    darkTheme == true
        ? animationController.forward()
        : animationController.reverse();
    WidgetsBinding.instance.addPostFrameCallback((_) => {setState(() => {})});
    super.initState();
  }

  bool futureToBoolDarkTheme() {
    getTheme().then((value) {
      darkTheme = value;
    });
    print(darkTheme);
    return darkTheme;
  }

  // Future<bool> getSwitchAnimationController() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final switchAnimationController = prefs.getBool('animation_controller');
  //   return switchAnimationController;
  // }

  @override
  Widget build(BuildContext context) {
    futureToBoolDarkTheme();
    return Container(
      decoration: BoxDecoration(color: primaryColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              darkTheme == true ? 'Disable Dark Mode' : 'Enable Dark Mode',
              style: TextStyle(
                  color: secondaryColor,
                  decoration: TextDecoration.none,
                  fontSize: 24),
            ),
            GestureDetector(
              onTap: () {
                initSharedPreferences(!darkTheme);
                darkTheme != true
                    ? animationController.reverse()
                    : animationController.forward();
                setState(() {});
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
