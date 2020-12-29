import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/screen/pic_of_day.dart';
import 'package:nasa_app/utils/shared_preferences.dart';
import 'package:nasa_app/widget/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMainMenuOpen = true;
  bool isPrevArrow = true;

  @override
  void initState() {
    super.initState();
    initSharedPreferences(true);
    getSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: isMainMenuOpen ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/planet.jpg'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isMainMenuOpen ? 0 : 1,
              child: PicOfDay()),
          MainMenu(
            isMainMenuOpen: isMainMenuOpen,
            setState: setStateMainMenu,
          ),
        ],
      ),
    );
  }

  void setStateMainMenu() {
    setState(() {
      isMainMenuOpen = !isMainMenuOpen;
    });
  }
}
