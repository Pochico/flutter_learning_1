import 'package:flutter/material.dart';
import 'package:nasa_app/model/asteroids_model.dart';
import 'package:nasa_app/repository/asteroids_repository.dart';
import 'asteroid_detail.dart';

class Asteroids extends StatefulWidget {
  @override
  _AsteroidsState createState() => _AsteroidsState();
}

class _AsteroidsState extends State<Asteroids> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<AsteroidsModel>(
          future: fetchAsteroids(3),
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
                                            )));
                              },
                              color: Colors.amber,
                              minWidth: 140,
                              child:
                                  Text(nearEarthObjects[index].nameLimited))),
                    );
                  });
              // Text(snapshot.data.nearEarthObjects[0].closeApproach[0]
              //     .close_approach_date),

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
}
