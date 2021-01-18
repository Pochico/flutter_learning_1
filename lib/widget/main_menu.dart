import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/screen/asteroid_graphs.dart';
import 'package:nasa_app/screen/settings.dart';
import 'package:nasa_app/screen/solar_system.dart';
import 'package:nasa_app/screen/rover_mars.dart';
import 'package:nasa_app/widget/clip_path.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key, @required this.isMainMenuOpen, @required this.setState})
      : super(key: key);
  final bool isMainMenuOpen;
  final Function setState;

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    //Animations: https://lottiefiles.com/recent
    animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      upperBound: 0.2,
      vsync: this,
    );
    animationController.value = 0.6;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOutBack,
      duration: Duration(milliseconds: 700),
      bottom: widget.isMainMenuOpen ? -30 : -290,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          menu(),
          buttonArrow(),
        ],
      ),
    );
  }

  Widget menu() {
    return ClipPath(
      clipper: CustomClipMenu(),
      child: Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.bottomCenter,
                radius: 1,
                colors: [
              Color.fromRGBO(0, 0, 0, 0.3),
              Color.fromRGBO(164, 80, 0, .9),
            ])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          mainMenuNavigationButton('Sistema Solar', SolarSystem()),
          mainMenuNavigationButton('Rover de Marte', RoverMars()),
          mainMenuNavigationButton('Gráficas de asteroides', AsteroidGraph()),
          mainMenuNavigationButton('Ajustes', SettingsScreen()),
        ]),
      ),
    );
  }

  Widget buttonArrow() {
    return GestureDetector(
      onVerticalDragStart: (i) => {
        widget.setState(),
        widget.isMainMenuOpen
            ? animationController.reverse()
            : animationController.forward(),
      },
      child: Container(
        alignment: Alignment.center,
        width: 48,
        height: 48,
        child: Center(
            child: Lottie.asset('assets/animations/arrow.json',
                controller: animationController,
                width: 30,
                delegates: LottieDelegates(values: [
                  ValueDelegate.color(
                      const ['ADBE Vector Graphic - Stroke', '**'],
                      value: secondaryColor)
                ]))),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Widget mainMenuNavigationButton(String titulo, Widget widget) {
    return Container(
      width: 240,
      child: RaisedButton(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: titulo == 'Ajustes'
              ? Center(
                  child: Lottie.asset(
                  'assets/animations/settings.json',
                  width: 30,
                ))
              : Text(
                  titulo,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor),
                ),
          onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget),
                ),
              }),
    );
  }
}
