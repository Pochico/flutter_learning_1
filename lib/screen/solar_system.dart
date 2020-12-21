import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/model/solar_system_model.dart';
import 'package:nasa_app/repository/solar_system_repository.dart';

class SolarSystem extends StatefulWidget {
  @override
  _SolarSystemState createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem> {
  List<String> planetElements;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<SolarSystemModel>(
          future: fetchSolarSystem(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('snapshot good');
              print(snapshot.data.solarSystem[0]);
              List<PlanetModel> solarSystem = snapshot.data.solarSystem;
              return Container(
                height: double.infinity,
                width: double.infinity,
                color: PRIMARY_COLOR,
                child: ListView.builder(
                    itemCount: snapshot.data.solarSystem.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                                height: 220,
                                color: PRIMARY_COLOR_SHADE,
                                child: Stack(children: [
                                  Transform.translate(
                                    offset: const Offset(220, -30),
                                    child: Image.asset(
                                        'assets/images/planet_1.png'),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        solarSystem[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            height: 2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: PRIMARY_COLOR,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Diameter: ' +
                                                      solarSystem[index]
                                                          .diameter
                                                          .toString() +
                                                      ' Km',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.6),
                                                ),
                                                Text(
                                                  'Density: ' +
                                                      solarSystem[index]
                                                          .density
                                                          .toString() +
                                                      ' g/cm³',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.6),
                                                ),
                                                Text(
                                                  'Mass: ' +
                                                      solarSystem[index].mass +
                                                      ' MØ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.6),
                                                ),
                                                Text(
                                                  'Gravity: ' +
                                                      solarSystem[index]
                                                          .gravity +
                                                      ' N/km',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.6),
                                                ),
                                                Text(
                                                  'Length of Day: ' +
                                                      solarSystem[index]
                                                          .dayLength +
                                                      ' Hours',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.6),
                                                ),
                                                Text(
                                                  'Distance from the Sun: ' +
                                                      solarSystem[index]
                                                          .sunDistance +
                                                      ' Km',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.6),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () => {
                                      //     print(solarSystem[index].name +
                                      //         ' was tapped')
                                      //   },
                                      //   child: Icon(
                                      //     Icons.keyboard_arrow_down,
                                      //     color: Colors.white,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ])),
                          ),
                        ]),
                      );
                    }),
              );
            } else {
              print('snapshot bad');
              print(snapshot);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
