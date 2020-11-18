import 'package:flutter/material.dart';
import 'package:nasa_app/model/pic_of_day_model.dart';
import 'package:nasa_app/repository/pic_of_day_repository.dart';
import 'package:nasa_app/widget/main_menu.dart';
import 'package:nasa_app/widget/arrows_index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool isTodayDate = true;
  bool isPrevArrow = true;

  String currentDayString;
  DateTime currentDay = DateTime.now();

  void fechaActual(DateTime currentDay) {
    int anoActual = currentDay.year;
    int mesActual = currentDay.month;
    int diaActual = currentDay.day;
    setState(() {
      currentDayString = '$anoActual-$mesActual-$diaActual';
    });
  }

  void initState() {
    super.initState();
    fechaActual(currentDay);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PicOfDayModel>(
      future: fetchAlbum(currentDayString),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                animOpacity(!isMainMenuOpen,
                    AssetImage('assets/images/planet.jpg'), '', '', false),
                animOpacity(isMainMenuOpen, NetworkImage(snapshot.data.url),
                    snapshot.data.title, snapshot.data.explanation, true),
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

  changeDate(DateTime newDate, bool sum) {
    newDate = sum
        ? newDate.add(Duration(days: 1))
        : newDate.subtract(Duration(days: 1));
    fechaActual(newDate);
    setState(() {
      currentDay = newDate;
    });
    compareDate();
  }

  compareDate() {
    int yearToday = DateTime.now().year;
    int monthToday = DateTime.now().month;
    int dayToday = DateTime.now().day;
    DateTime today = DateTime.utc(yearToday, monthToday, dayToday);
    DateTime currentDayUtc =
        DateTime.utc(currentDay.year, currentDay.month, currentDay.day);
    setState(() {
      today.compareTo(currentDayUtc) == 0
          ? isTodayDate = true
          : isTodayDate = false;
    });
  }

  Widget animOpacity(bool isMainMenuOpen, ImageProvider<Object> imagen,
      String title, String explanation, bool isDescription) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 700),
      opacity: isMainMenuOpen ? 0 : 1,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: imagen,
            fit: BoxFit.cover,
          )),
        ),
        Align(
          alignment: Alignment(0, 1),
          child: Container(
            height: double.infinity,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(68, 32, 68, 80),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 16,
                      top: MediaQuery.of(context).size.height - 200),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  explanation,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  currentDayString,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
        arrowsMainScreen(true, isDescription),
        isTodayDate ? SizedBox() : arrowsMainScreen(false, isDescription),
      ]),
    );
  }

  arrowsMainScreen(bool direccionFlecha, bool isDescription) {
    return Align(
        alignment:
            direccionFlecha ? Alignment.centerLeft : Alignment.centerRight,
        child: isDescription
            ? direccionFlecha
                ? GestureDetector(
                    onTap: () => changeDate(currentDay, false),
                    child: ArrowsIndex(isPreviousArrow: true))
                : GestureDetector(
                    onTap: () => changeDate(currentDay, true),
                    child: ArrowsIndex(isPreviousArrow: false))
            : SizedBox());
  }
}
