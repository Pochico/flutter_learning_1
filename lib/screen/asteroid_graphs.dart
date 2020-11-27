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
  //List<double> asteroidesEjeX = [0, 1, 2, 3];
  // List<double> asteroidesEjeY = [7, 7, 7, 7, 4, 4, 4, 4];
  List<Color> colorList = [
    ASTEROID_COLOR_1,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_3,
    ASTEROID_COLOR_4,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_2,
    ASTEROID_COLOR_2,
  ];

  List<ScatterSpot> readyToUseAsteroidList;
  int lastPanStartOnIndex = -1;

  bool soyElPlanetaTal = false;

  @override
  void initState() {
    super.initState();
    fetchedStartDate = dateTimeToString(currentDay);
    fetchedEndDate = dateTimeToString(addDay(currentDay));
  }

  void asteroidList(List<NearEarthObjects> asteroids) {
    var loQueRetorna = asteroids
        .asMap()
        .map((index, e) => MapEntry(
            index,
            ScatterSpot(
              (index.toDouble() + 1),
              (1),
              color: colorList[index],
              radius: (e.asteroidSize.kmDiameter.maxDiameter),
            )))
        .values
        .toList();
    readyToUseAsteroidList = loQueRetorna;
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
                    aspectRatio: 3,
                    child: Card(
                      color: PRIMARY_COLOR,
                      child: ScatterChart(
                        ScatterChartData(
                          scatterSpots: [
                            ...readyToUseAsteroidList,
                          ],
                          minX: 0,
                          maxX: 11,
                          minY: 0,
                          maxY: 2,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          gridData: FlGridData(
                            show: false,
                            drawHorizontalLine: false,
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
                              tooltipBgColor: Colors.amber,
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
                                      setState(() {
                                        soyElPlanetaTal = false;
                                      });
                                    } else {
                                      selectedSpots.add(lastPanStartOnIndex);
                                      setState(() {
                                        soyElPlanetaTal = true;
                                      });
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
            soyElPlanetaTal
                ? Center(
                    child: Text(
                    'SOY EL PLANETA YTAL',
                    style: TextStyle(color: Colors.red),
                  ))
                : SizedBox(),
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
