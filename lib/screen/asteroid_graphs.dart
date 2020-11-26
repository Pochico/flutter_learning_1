import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nasa_app/model/asteroids_model.dart';
import 'package:nasa_app/repository/asteroids_repository.dart';
import 'package:nasa_app/widget/calendar.dart';
import 'package:nasa_app/utils/date.dart';

class AsteroidGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AsteroidGraphState();
}

class _AsteroidGraphState extends State {
  DateTime startDate = DateTime.now();
  String fetchedStartDate;
  String fetchedEndDate;

  int touchedIndex;

  Color greyColor = Colors.grey;

  List<int> selectedSpots = [];

  int lastPanStartOnIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchedStartDate = dateTimeToString(startDate);
    fetchedEndDate = dateTimeToString(addDay(startDate));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<AsteroidsModel>(
        future: fetchAsteroids(1, fetchedStartDate, fetchedEndDate),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var asteroids = snapshot.data;
            var nearEarthObjects = asteroids.nearEarthObjects;
            print(nearEarthObjects[1].asteroidSize.kmDiameter.maxDiameter);
            return Stack(children: [
              AspectRatio(
                aspectRatio: 1,
                child: Card(
                  color: const Color(0xff222222),
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: [
                        ScatterSpot(
                          4,
                          4,
                          color: selectedSpots.contains(0)
                              ? Colors.green
                              : greyColor,
                        ),
                        ScatterSpot(
                          2,
                          5,
                          color: selectedSpots.contains(1)
                              ? Colors.yellow
                              : greyColor,
                          radius: nearEarthObjects[1]
                                  .asteroidSize
                                  .kmDiameter
                                  .maxDiameter *
                              2,
                        ),
                        ScatterSpot(
                          4,
                          5,
                          color: selectedSpots.contains(2)
                              ? Colors.purpleAccent
                              : greyColor,
                          radius: nearEarthObjects[2]
                                  .asteroidSize
                                  .kmDiameter
                                  .maxDiameter *
                              2,
                        ),
                        ScatterSpot(
                          8,
                          6,
                          color: selectedSpots.contains(3)
                              ? Colors.orange
                              : greyColor,
                          radius: 20,
                        ),
                        ScatterSpot(
                          5,
                          7,
                          color: selectedSpots.contains(4)
                              ? Colors.brown
                              : greyColor,
                          radius: 14,
                        ),
                        ScatterSpot(
                          7,
                          2,
                          color: selectedSpots.contains(5)
                              ? Colors.lightGreenAccent
                              : greyColor,
                          radius: 18,
                        ),
                        ScatterSpot(
                          3,
                          2,
                          color: selectedSpots.contains(6)
                              ? Colors.red
                              : greyColor,
                          radius: 36,
                        ),
                        ScatterSpot(
                          2,
                          8,
                          color: selectedSpots.contains(7)
                              ? Colors.tealAccent
                              : greyColor,
                          radius: 22,
                        ),
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
                            FlLine(color: Colors.white.withOpacity(0.1)),
                        drawVerticalLine: true,
                        checkToShowVerticalLine: (value) => true,
                        getDrawingVerticalLine: (value) =>
                            FlLine(color: Colors.white.withOpacity(0.1)),
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
                        touchCallback: (ScatterTouchResponse touchResponse) {
                          if (touchResponse.touchInput is FlPanStart) {
                            lastPanStartOnIndex =
                                touchResponse.touchedSpotIndex;
                          } else if (touchResponse.touchInput is FlPanEnd) {
                            final FlPanEnd flPanEnd = touchResponse.touchInput;

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
              ),
            ]);
          } else {
            return Center(
                child:
                    Text('Failed to retrieve the data from the Asteroids API'));
          }
        },
      ),
    );
  }

  setStateCalendar() {
    setState(() {});
  }
}
