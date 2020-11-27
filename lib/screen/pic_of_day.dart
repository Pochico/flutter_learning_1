import 'package:flutter/material.dart';
import 'package:nasa_app/repository/pic_of_day_repository.dart';
import 'package:nasa_app/model/pic_of_day_model.dart';
import 'package:nasa_app/widget/arrows_index.dart';
import 'package:nasa_app/utils/date.dart';

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
    dateTimeToString(currentDay);
    setState(() {
      currentDayString = dateTimeToString(currentDay);
    });
    print(currentDay);
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
              onTap: () => changeDateSub(currentDay),
              child: ArrowsIndex(isPreviousArrow: true))
          : GestureDetector(
              onTap: () => changeDateAdd(currentDay),
              child: ArrowsIndex(isPreviousArrow: false)),
    );
  }

  changeDateSub(DateTime dateToChange) {
    comparisonDateSetState(subDay(dateToChange));
    setState(() {
      currentDay = subDay(dateToChange);
      currentDayString = dateTimeToString(currentDay);
    });
  }

  changeDateAdd(DateTime dateToChange) {
    comparisonDateSetState(addDay(dateToChange));
    setState(() {
      currentDay = addDay(dateToChange);
      currentDayString = dateTimeToString(currentDay);
    });
  }

  comparisonDateSetState(DateTime dateToCompare) {
    setState(() {
      compareDate(dateToCompare) ? isTodayDate = true : isTodayDate = false;
    });
  }
}
