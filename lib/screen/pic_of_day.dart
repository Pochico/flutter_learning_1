import 'package:flutter/material.dart';
import 'package:nasa_app/repository/pic_of_day_repository.dart';
import 'package:nasa_app/model/pic_of_day_model.dart';
import 'package:nasa_app/widget/arrows_index.dart';

class PicOfDay extends StatefulWidget {
  PicOfDay({Key key}) : super(key: key);

  @override
  _PicOfDayState createState() => _PicOfDayState();
}

class _PicOfDayState extends State<PicOfDay> {
  bool isTodayDate = true;
  String currentDayString;
  DateTime currentDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    fechaActual(currentDay);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PicOfDayModel>(
        future: fetchAlbum(currentDayString),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasData) {
            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(data.url),
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
                          data.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        data.explanation,
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
              arrowsMainScreen(true),
              isTodayDate ? SizedBox() : arrowsMainScreen(false),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  arrowsMainScreen(bool direccionFlecha) {
    return Align(
      alignment: direccionFlecha ? Alignment.centerLeft : Alignment.centerRight,
      child: direccionFlecha
          ? GestureDetector(
              onTap: () => changeDate(currentDay, false),
              child: ArrowsIndex(isPreviousArrow: true))
          : GestureDetector(
              onTap: () => changeDate(currentDay, true),
              child: ArrowsIndex(isPreviousArrow: false)),
    );
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

  void fechaActual(DateTime currentDay) {
    int anoActual = currentDay.year;
    int mesActual = currentDay.month;
    int diaActual = currentDay.day;
    setState(() {
      currentDayString = '$anoActual-$mesActual-$diaActual';
    });
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
}
