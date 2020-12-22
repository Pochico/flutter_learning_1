import 'package:flutter/material.dart';
import 'package:nasa_app/model/asteroids_model.dart';

class AsteroidListTile extends StatelessWidget {
  AsteroidListTile({
    Key key,
    @required this.nearEarthObjectsVariable,
    @required this.neovIndex,
    @required this.colorList,
  });
  final List<NearEarthObjects> nearEarthObjectsVariable;
  final int neovIndex;
  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: RichText(
          text: TextSpan(
        text: nearEarthObjectsVariable[neovIndex].nameLimited,
        style:
            TextStyle(fontWeight: FontWeight.bold, color: colorList[neovIndex]),
        children: <TextSpan>[
          TextSpan(
              text: '\n' +
                  (nearEarthObjectsVariable[neovIndex]
                              .asteroidSize
                              .kmDiameter
                              .maxDiameter *
                          100)
                      .toStringAsFixed(3) +
                  ' mØ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: colorList[neovIndex]))
        ],
      )),
      trailing: Container(
        width: 30,
        alignment: Alignment.center,
        child: Container(
          height: nearEarthObjectsVariable[neovIndex]
                  .asteroidSize
                  .kmDiameter
                  .maxDiameter *
              3,
          width: nearEarthObjectsVariable[neovIndex]
                  .asteroidSize
                  .kmDiameter
                  .maxDiameter *
              3,
          decoration: BoxDecoration(
              color: colorList[neovIndex],
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
