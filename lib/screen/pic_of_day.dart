import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/repository/pic_of_day_repository.dart';
import 'package:nasa_app/model/pic_of_day_model.dart';
import 'package:nasa_app/widget/arrows_index.dart';
import 'package:nasa_app/utils/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PicOfDay extends StatefulWidget {
  PicOfDay({Key key}) : super(key: key);

  @override
  _PicOfDayState createState() => _PicOfDayState();
}

//TODO Caché. Consiste en guardar en un estado un array con los datos de cada día, al ir hacia atrás hace el fetch pero al voler hacia alante primero comprueba si hay datos de ese día guardados y los coge, sino hace el fetch

class _PicOfDayState extends State<PicOfDay> {
  bool isTodayDate = true;
  String currentDayString;
  DateTime currentDay = DateTime.now();
  bool readingOpacity = false;
  List<Object> cachedImages = [];

  @override
  void initState() {
    super.initState();
    dateTimeToString(currentDay);
    // getSharedData();
    setState(() {
      currentDayString = dateTimeToString(currentDay);
    });
  }

  void formatData(PicOfDayModel datos) {
    Map<String, dynamic> objeto = {
      'Pic of day objeto': {
        'fecha': datos.date.toString(),
        'title': datos.title,
        'explanation': datos.explanation,
        'image': datos.url,
        'date': datos.date.toString()
      }
    };

    cachedImages.add(objeto);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: solucionar el doble run del futurebuilder, rellena 2 veces el cachedimages
    return FutureBuilder<PicOfDayModel>(
        future: fetchAlbum(currentDayString),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (!cachedImages.contains(currentDayString)) {
            if (snapshot.hasData) {
              formatData(snapshot.data);
              return Stack(children: [
                data.url.contains('apod.nasa')
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(snapshot.data.url),
                          fit: BoxFit.cover,
                        )),
                      )
                    : Text(data.url), //TODO Video de youtube
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
                    setOpacityState();
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
                          color: PRIMARY_COLOR.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2.0, color: Colors.grey),
                        ),
                        child:
                            Icon(Icons.panorama_fish_eye, color: Colors.grey),
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
          }
          /*else {
            var indice = cachedImages.where((objeto) =>
                objeto.['Pic of day objeto']['fecha'] == currentDayString);
            return PreLoadedPicOfDay(
                cachedImages: cachedImages,
                isTodayDate: isTodayDate,
                readingOpacity: readingOpacity,
                currentDayString: currentDayString,
                arrowsMainScreen: arrowsMainScreen(true),
                setOpacityState: setOpacityState);
          }*/
        });
  }

  Widget arrowsMainScreen(bool direccionFlecha) {
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

  void changeDateSub(DateTime dateToChange) {
    comparisonDateSetState(subDay(dateToChange));
    setState(() {
      currentDay = subDay(dateToChange);
      currentDayString = dateTimeToString(currentDay);
    });
  }

  void changeDateAdd(DateTime dateToChange) {
    comparisonDateSetState(addDay(dateToChange));
    setState(() {
      currentDay = addDay(dateToChange);
      currentDayString = dateTimeToString(currentDay);
    });
  }

  void comparisonDateSetState(DateTime dateToCompare) {
    setState(() {
      compareDate(dateToCompare) ? isTodayDate = true : isTodayDate = false;
    });
  }

  void setOpacityState() {
    setState(() {
      readingOpacity = !readingOpacity;
    });
  }

  // Solución que no acabo de asociar a mi caso para el doble build del FutureBuilder
  // https://stackoverflow.com/questions/58664293/futurebuilder-runs-twice

}
