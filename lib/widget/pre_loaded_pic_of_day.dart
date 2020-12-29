/*import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/screen/pic_of_day.dart';

class PreLoadedPicOfDay extends StatelessWidget {
  PreLoadedPicOfDay(
      {Key key,
      @required this.cachedImages,
      @required this.isTodayDate,
      @required this.readingOpacity,
      @required this.currentDayString,
      @required this.setOpacityState,
      @required this.arrowsMainScreen});
  List<Object> cachedImages;
  bool isTodayDate;
  bool readingOpacity;
  String currentDayString;
  Function setOpacityState;
  Widget arrowsMainScreen;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      cachedImages[index].url.contains('apod.nasa')
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(cachedImages[index].url),
                fit: BoxFit.cover,
              )),
            )
          : Text(cachedImages[index].url), //TODO Video de youtube
      AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: readingOpacity ? 0.8 : 0,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.8)),
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
                    bottom: 16, top: MediaQuery.of(context).size.height - 200),
                child: Text(
                  cachedImages[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                cachedImages[index].explanation,
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
          setOpacityState();
        },
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR.withOpacity(0.5),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2.0, color: Colors.grey),
              ),
              child: Icon(Icons.panorama_fish_eye, color: Colors.grey),
            ),
          ),
        ),
      ),
      arrowsMainScreen,
      isTodayDate ? SizedBox() : arrowsMainScreen,
    ]);
  }
}
*/
