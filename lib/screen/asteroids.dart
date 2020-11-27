import 'package:flutter/material.dart';
import 'package:nasa_app/model/asteroids_model.dart';
import 'package:nasa_app/repository/asteroids_repository.dart';
import 'asteroid_detail.dart';

class Asteroids extends StatefulWidget {
  @override
  _AsteroidsState createState() => _AsteroidsState();
}

class _AsteroidsState extends State<Asteroids> {
  String currentDayString;
  String endDayString;
  DateTime currentDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    fechaActual(currentDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<AsteroidsModel>(
          future: fetchAsteroids(1, currentDayString, endDayString),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var asteroids = snapshot.data;
              var nearEarthObjects = asteroids.nearEarthObjects;
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.nearEarthObjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 70,
                      child: Center(
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AsteroidDetail(
                                              closeApproachList:
                                                  nearEarthObjects[index]
                                                      .closeApproach,
                                              title: nearEarthObjects[index]
                                                  .nameLimited,
                                              size: nearEarthObjects[index]
                                                  .asteroidSize
                                                  .kmDiameter
                                                  .maxDiameter,
                                            )));
                              },
                              color: Colors.amber,
                              minWidth: 140,
                              child:
                                  Text(nearEarthObjects[index].nameLimited))),
                    );
                  });
            } else {
              return Center(
                  child: Text(
                      'Failed to retrieve the data from the Asteroids API'));
            }
          },
        ),
      ),
    );
  }

  void fechaActual(DateTime currentDay) {
    int startYear = currentDay.year;
    int startMonth = currentDay.month;
    int startDay = currentDay.day;

    DateTime fechaFinal = currentDay.add(Duration(days: 1));
    int endYear = fechaFinal.year;
    int endMonth = fechaFinal.month;
    int endDay = fechaFinal.day;

    setState(() {
      currentDayString = '$startYear-$startMonth-$startDay';
      endDayString = '$endYear-$endMonth-$endDay';
    });
  }
}
