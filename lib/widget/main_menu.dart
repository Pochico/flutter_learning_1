import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/screen/asteroid_graphs.dart';
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

class _MainMenuState extends State<MainMenu> {
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
        ]),
      ),
    );
  }

  Widget buttonArrow() {
    return GestureDetector(
      onVerticalDragStart: (i) => {widget.setState()},
      child: Container(
        alignment: Alignment.center,
        width: 48,
        height: 48,
        child: Icon(
            widget.isMainMenuOpen
                ? Icons.keyboard_arrow_down
                : Icons.keyboard_arrow_up,
            size: 40,
            color: Colors.white),
        // Center(child: Lottie.asset('assets/animations/arrow.json')),
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Widget mainMenuNavigationButton(String titulo, Widget widget) {
    return ButtonTheme(
      minWidth: 140,
      child: RaisedButton(
        color: Color(0xFF17161b),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          titulo,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFFf2c902)),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        ),
      ),
    );
  }
}
