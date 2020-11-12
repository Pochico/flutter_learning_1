import 'package:flutter/material.dart';
import 'package:nasa_app/model/asteroids_model.dart';

class AsteroidDetail extends StatelessWidget {
  const AsteroidDetail(
      {Key key, @required this.closeApproachList, @required this.title})
      : super(key: key);
  final String title;
  final List<CloseApproach> closeApproachList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asteroid Details - ' + title), //Aquí podría ir el title
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.ac_unit_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: closeApproachList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 32),
                    Text(
                      'Fecha de aproximación: ' +
                          closeApproachList[index].closeApproachDate,
                      style: TextStyle(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      closeApproachList[index].closeApproachDateFull,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              })),
    );
  }
}
