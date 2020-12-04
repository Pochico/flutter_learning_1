import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
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
  bool readingOpacity = false;

  @override
  void initState() {
    super.initState();
    dateTimeToString(currentDay);
    setState(() {
      currentDayString = dateTimeToString(currentDay);
    });
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
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: readingOpacity
                        ? Colors.black.withOpacity(.7)
                        : Colors.transparent),
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
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Tapped');
                  setState(() {
                    readingOpacity = !readingOpacity;
                  });
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 24),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2.0, color: Colors.white),
                      ),
                      child: Icon(
                        Icons.panorama_fish_eye,
                        color: Colors.white,
                      ),
                    ),
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
