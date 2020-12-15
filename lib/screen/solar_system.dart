import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/model/solar_system_model.dart';
import 'package:nasa_app/repository/solar_system_repository.dart';

class SolarSystem extends StatefulWidget {
  @override
  _SolarSystemState createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem> {
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
                        child: Container(
                            decoration: BoxDecoration(
                                color: PRIMARY_COLOR_SHADE,
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
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
                                      borderRadius: BorderRadius.circular(4),
                                      color: PRIMARY_COLOR,
                                    ),
                                    child: Text(
                                      solarSystem[index].id.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            )),
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
