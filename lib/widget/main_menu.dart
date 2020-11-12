import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/screen/asteroids.dart';
import 'package:nasa_app/screen/pic_of_day.dart';
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
            /*   boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                        ),
                        BoxShadow(
                          color: Colors.blue,
                          spreadRadius: -12.0,
                          blurRadius: 12.0,
                          offset: Offset(0, 10),
                        ),
                      ],*/ //mejor un borde
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(164, 80, 0, 0.8),
              Color.fromRGBO(0, 0, 0, 0.3),
            ])),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ButtonTheme(
            minWidth: 140,
            child: RaisedButton(
              color: Colors.amberAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Foto del dia',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PicOfDay()),
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 140,
            child: RaisedButton(
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Rover de Marte',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoverMars()),
              ),
            ),
          ),
          ButtonTheme(
            minWidth: 140,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Colors.orangeAccent,
              child: Text(
                'Asteroides',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Asteroids()),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget buttonArrow() {
    return GestureDetector(
      onVerticalDragStart: (i) => {widget.setState()},
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            image: AssetImage('assets/images/up_menu.png'),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.6),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
