import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/model/rover_mars_model.dart';
import 'package:nasa_app/utils/date.dart';
import 'package:nasa_app/repository/rover_mars_repository.dart';
import 'package:nasa_app/screen/rover_mars_detail.dart';
import 'package:nasa_app/widget/calendar.dart';
import 'package:nasa_app/widget/clip_path.dart';

final colorBase = PRIMARY_COLOR.withOpacity(.5);

class RoverMars extends StatefulWidget {
  RoverMars({Key key}) : super(key: key);

  @override
  _RoverMarsState createState() => _RoverMarsState();
}

class _RoverMarsState extends State<RoverMars> {
  int columnCount = 2;
  DateTime currentDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void changeGridCounter(bool suma) {
    setState(() {
      if (suma) {
        if (columnCount < 5) columnCount++;
      } else {
        if (columnCount > 1) columnCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0C0E),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: FutureBuilder<List<RoverMarsModel>>(
        future: fetchPhotoRovers(dateTimeToString(currentDay)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var roverItems = snapshot.data;
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 45),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: columnCount,
                        children: List.generate(roverItems.length, (index) {
                          return Center(
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoverMarsDetail(
                                          roverItemDetailed:
                                              roverItems[index]))),
                              child: Hero(
                                tag: roverItems[index].imgSrc,
                                child: Image.network(
                                  roverItems[index].imgSrc,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment(0, .5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gridCounterButtons(false),
                      gridCounterButtons(true)
                    ],
                  ),
                ),
                roverMarsHeader(),
                Align(
                  alignment: Alignment(0, -.8),
                  child: Calendar(
                    setState: setFetchedDate,
                    currentDay: currentDay,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }

  void setFetchedDate(DateTime date) {
    setState(() {
      currentDay = date;
    });
  }

  Widget gridCounterButtons(bool isRight) {
    return GestureDetector(
        onTap: () => changeGridCounter(isRight),
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(
                left: isRight ? 24 : 0,
                right: isRight ? 0 : 24,
                top: 16,
                bottom: 16),
            child: Container(
                alignment:
                    isRight ? Alignment(0.5, -0.05) : Alignment(-0.5, -0.05),
                width: 20,
                height: 40,
                decoration: BoxDecoration(
                  color: colorBase,
                  borderRadius: isRight
                      ? BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        )
                      : BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                ),
                child: Text(
                  isRight ? '+' : '-',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFf2c902),
                  ),
                )),
          ),
        ));
  }

  Widget roverMarsHeader() {
    return ClipPath(
      clipper: CustomClipRoverHeader(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: colorBase,
          height: 125,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Rovers Curiosity',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFf2c902)),
                ),
              ),
              Text(
                dateTimeToString(currentDay),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFf2c902)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
