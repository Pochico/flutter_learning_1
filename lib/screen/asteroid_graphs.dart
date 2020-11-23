import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart' as graphic;

class AsteroidGraphs extends StatefulWidget {
  @override
  _AsteroidGraphsState createState() => _AsteroidGraphsState();
}

class _AsteroidGraphsState extends State<AsteroidGraphs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Padding(
              padding: const EdgeInsets.all(32),
              child: graphic.Chart(
                data: [
                  {'name': 'Sports', 'size': 205},
                  {'name': 'Strategy', 'size': 115},
                  {'name': 'Action', 'size': 1120},
                  {'name': 'Shooter', 'size': 350},
                  {'name': 'Other', 'size': 130},
                ],
                scales: {
                  'name': graphic.CatScale(
                    accessor: (map) => map['name'] as String,
                  ),
                  'size': graphic.LinearScale(
                    accessor: (map) => map['size'] as num,
                    nice: false,
                  )
                },
                geoms: [
                  graphic.IntervalGeom(
                    position: graphic.PositionAttr(field: 'name*size'),
                  )
                ],
                axes: {
                  'name': graphic.Defaults.horizontalAxis,
                  'size': graphic.Defaults.verticalAxis,
                },
              ))),
    );
  }
}
