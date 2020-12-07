import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/model/asteroids_model.dart';
import 'package:nasa_app/repository/asteroids_repository.dart';
import 'package:nasa_app/widget/calendar.dart';
import 'package:nasa_app/utils/date.dart';
import 'package:nasa_app/widget/clip_path.dart';

class AsteroidGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AsteroidGraphState();
}

class _AsteroidGraphState extends State {
  DateTime currentDay = DateTime.now();
  String fetchedStartDate;
  String fetchedEndDate;

  int touchedIndex;
  Color greyColor = Colors.grey;
  List<int> selectedSpots = [];
  final List<Color> colorList = [
    ASTEROID_COLOR_1,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_3,
    ASTEROID_COLOR_4,
    ASTEROID_COLOR_5,
    ASTEROID_COLOR_6,
    ASTEROID_COLOR_7,
    ASTEROID_COLOR_8,
    ASTEROID_COLOR_9,
    ASTEROID_COLOR_10,
  ];

  List<ScatterSpot> readyToUseAsteroidList;
  int lastPanStartOnIndex = -1;

  bool touchedAsteroid = false;
  List<NearEarthObjects> nearEarthObjectsVariable;
  int usableTouchedSpotIndex;

  List<int> xAxisLocation = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4];
  List<int> asteroidsData = [];

  @override
  void initState() {
    super.initState();
  }

// TODO: Put the asteroids in the graphic in order to get 2 lines horizontally.

  void asteroidList(List<NearEarthObjects> asteroids) {
    var loQueRetorna = asteroids
        .asMap()
        .map((index, e) => MapEntry(
            index,
            ScatterSpot(
              (xAxisLocation[index].toDouble() + 1),
              (index > 4 ? 2 : 5),
              color: colorList[index],
              radius: (e.asteroidSize.kmDiameter.maxDiameter * 1.5),
            )))
        .values
        .toList();
    readyToUseAsteroidList = loQueRetorna;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [PRIMARY_COLOR, PRIMARY_COLOR.withOpacity(.5)],
                  stops: [.7, 1])),
          child: Column(
            children: [
              ClipPath(
                clipper: CustomClipAsteroidsGraph(),
                child: Container(
                  padding: EdgeInsets.only(left: 50, bottom: 20, top: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      'Asteroids graphic: ' + dateTimeToString(currentDay),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: SECONDARY_COLOR),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<AsteroidsModel>(
                future: fetchAsteroids(1, dateTimeToString(currentDay),
                    dateTimeToString(addDay(currentDay))),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var asteroids = snapshot.data;
                    nearEarthObjectsVariable = asteroids.nearEarthObjects;
                    asteroidList(nearEarthObjectsVariable);
                    return Transform.scale(
                      scale: 1.2,
                      child: AspectRatio(
                        aspectRatio: 2.5,
                        child: Card(
                          color: PRIMARY_COLOR,
                          child: ScatterChart(
                            ScatterChartData(
                              scatterSpots: [
                                ...readyToUseAsteroidList,
                              ],
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 7,
                              borderData: FlBorderData(
                                show: false,
                              ),
                              gridData: FlGridData(
                                show: false,
                                drawHorizontalLine: false,
                              ),
                              titlesData: FlTitlesData(
                                show: false,
                              ),
                              scatterTouchData: ScatterTouchData(
                                enabled: false,
                                handleBuiltInTouches: false,
                                touchCallback:
                                    (ScatterTouchResponse touchResponse) {
                                  touchCall(touchResponse);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                        child: Text(
                            'Failed to retrieve the data from the Asteroids API'));
                  }
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 20, left: 16),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: Calendar(
              //       setState: setFetchedDate,
              //       currentDay: currentDay,
              //     ),
              //   ),
              // ),
              touchedAsteroid
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: readyToUseAsteroidList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: RichText(
                                    text: TextSpan(
                              text: nearEarthObjectsVariable[index].nameLimited,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorList[index]),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '\n' +
                                        nearEarthObjectsVariable[index]
                                            .asteroidSize
                                            .kmDiameter
                                            .maxDiameter
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorList[index]))
                              ],
                            )));
                          }),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // void setFetchedDate(DateTime date) {
  //   setState(() {
  //     currentDay = date;
  //   });
  // }

  void touchCall(dynamic touchResponse) {
    if (touchResponse.touchInput is FlPanStart &&
        touchResponse.touchedSpotIndex != -1) {
      usableTouchedSpotIndex =
          lastPanStartOnIndex = touchResponse.touchedSpotIndex;
      asteroidsData.contains(touchResponse.touchedSpotIndex)
          ? asteroidsData.remove(touchResponse.touchedSpotIndex)
          : asteroidsData.add(touchResponse.touchedSpotIndex);
    } else if (touchResponse.touchInput is FlPanEnd) {
      final FlPanEnd flPanEnd = touchResponse.touchInput;

      if (flPanEnd.velocity.pixelsPerSecond <= const Offset(4, 4)) {
        setState(() {
          if (selectedSpots.contains(lastPanStartOnIndex)) {
            selectedSpots.remove(lastPanStartOnIndex);
          } else {
            selectedSpots.add(lastPanStartOnIndex);
            setState(() {
              touchedAsteroid = true;
            });
          }
        });
      }
    }
  }
}
