import 'package:flutter/material.dart';
import 'package:nasa_app/model/pic_of_day_model.dart';
import 'package:nasa_app/repository/pic_of_day_repository.dart';
import 'package:nasa_app/widget/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PicOfDayModel>(
      future: fetchAlbum(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                animOpacity(isMainMenuOpen, NetworkImage(snapshot.data.url)),
                animOpacity(
                    !isMainMenuOpen, AssetImage('assets/images/planet.jpg')),
                MainMenu(
                  isMainMenuOpen: isMainMenuOpen,
                  setState: setStateMainMenu,
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void setStateMainMenu() {
    setState(() {
      isMainMenuOpen = !isMainMenuOpen;
    });
  }

  Widget animOpacity(bool isMainMenuOpen, ImageProvider<Object> imagen) {
    print(isMainMenuOpen);
    return AnimatedOpacity(
      duration: Duration(milliseconds: 700),
      opacity: isMainMenuOpen ? 0 : 1,
      child: Stack(children: [
        Container(
          //aqui el stack para el texto
          decoration: BoxDecoration(
              image: DecorationImage(
            image: imagen,
            fit: BoxFit.cover,
          )),
        ),
      ]),
    );
  }
}
