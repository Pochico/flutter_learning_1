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
              print(snapshot);
              return Container(height: 20, width: 20, color: PRIMARY_COLOR);
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
