import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/model/asteroids_model.dart';
import 'package:nasa_app/repository/asteroids_repository.dart';
import 'package:nasa_app/widget/calendar.dart';
import 'package:nasa_app/utils/date.dart';

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
  List<double> asteroidesEjeX = [0, 1, 2, 3];
  // List<double> asteroidesEjeY = [7, 7, 7, 7, 4, 4, 4, 4];
  List<Color> colorList = [
    ASTEROID_COLOR_1,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_3,
    ASTEROID_COLOR_4,
  ];

  List<ScatterSpot> readyToUseAsteroidList;

  int lastPanStartOnIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchedStartDate = dateTimeToString(currentDay);
    fetchedEndDate = dateTimeToString(addDay(currentDay));
    readyToUseAsteroidList = asteroidList();
  }

  List<ScatterSpot> asteroidList(List<NearEarthObjects> asteroids) {
    var loQueRetorna = asteroidesEjeX
        .map(
          (e) => ScatterSpot((e + 1) * 2, (e + 1) * 2,
              color: colorList[e.toInt()], radius: (e + 1) * 3),
        )
        .toList();
    return loQueRetorna;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<AsteroidsModel>(
              future: fetchAsteroids(1, fetchedStartDate, fetchedEndDate),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var asteroids = snapshot.data;
                  var nearEarthObjects = asteroids.nearEarthObjects;
                  asteroidList(nearEarthObjects);
                  return AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      color: const Color(0xff222222),
                      child: ScatterChart(
                        ScatterChartData(
                          scatterSpots: [
                            ...readyToUseAsteroidList,
                            //    ScatterSpot(
                            //   2,
                            //   5,
                            //   color: selectedSpots.contains(1)
                            //       ? Colors.yellow
                            //       : greyColor,
                            //   radius: nearEarthObjects[1]
                            //           .asteroidSize
                            //           .kmDiameter
                            //           .maxDiameter *
                            //       2,
                            // ),
                          ],
                          minX: 0,
                          maxX: 10,
                          minY: 0,
                          maxY: 10,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawHorizontalLine: true,
                            checkToShowHorizontalLine: (value) => true,
                            getDrawingHorizontalLine: (value) =>
                                FlLine(color: Colors.white.withOpacity(0.05)),
                            drawVerticalLine: true,
                            checkToShowVerticalLine: (value) => true,
                            getDrawingVerticalLine: (value) =>
                                FlLine(color: Colors.white.withOpacity(0.05)),
                          ),
                          titlesData: FlTitlesData(
                            show: false,
                          ),
                          showingTooltipIndicators: selectedSpots,
                          scatterTouchData: ScatterTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchTooltipData: ScatterTouchTooltipData(
                              tooltipBgColor: Colors.black,
                            ),
                            touchCallback:
                                (ScatterTouchResponse touchResponse) {
                              if (touchResponse.touchInput is FlPanStart) {
                                lastPanStartOnIndex =
                                    touchResponse.touchedSpotIndex;
                              } else if (touchResponse.touchInput is FlPanEnd) {
                                final FlPanEnd flPanEnd =
                                    touchResponse.touchInput;

                                if (flPanEnd.velocity.pixelsPerSecond <=
                                    const Offset(4, 4)) {
                                  // Tap happened
                                  setState(() {
                                    if (selectedSpots
                                        .contains(lastPanStartOnIndex)) {
                                      selectedSpots.remove(lastPanStartOnIndex);
                                    } else {
                                      selectedSpots.add(lastPanStartOnIndex);
                                    }
                                  });
                                }
                              }
                            },
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
            Calendar(
              setState: setFetchedDate,
              currentDay: currentDay,
            ),
          ],
        ),
      ),
    );
  }

  void setFetchedDate(DateTime date) {
    setState(() {
      currentDay = date;
    });
  }
}
