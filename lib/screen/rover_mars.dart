import 'package:flutter/material.dart';
import 'package:nasa_app/model/rover_mars_model.dart';
import 'package:nasa_app/repository/rover_mars_repository.dart';

class RoverMars extends StatefulWidget {
  RoverMars({Key key}) : super(key: key);

  @override
  _RoverMarsState createState() => _RoverMarsState();
}

class _RoverMarsState extends State<RoverMars> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: FutureBuilder<List<RoverMarsModel>>(
      future: fetchPhotoRovers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var roverItems = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 600,
                width: 450,
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(roverItems.length, (index) {
                    return Center(
                      child: Column(
                        children: [
                          // Text(
                          //   roverItems[index].id.toString(),
                          //   style: Theme.of(context).textTheme.headline5,
                          // ),
                          Image.network(
                            roverItems[index].imgSrc,
                            height: 140,
                          ),
                          Text(roverItems[index].camera.fullName),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    )));
  }
}
