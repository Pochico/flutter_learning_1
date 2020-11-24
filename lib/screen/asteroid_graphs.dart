import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class AsteroidGraphs extends StatefulWidget {
  @override
  _AsteroidGraphsState createState() => _AsteroidGraphsState();
}

class _AsteroidGraphsState extends State<AsteroidGraphs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Echarts(
        option: '''
    {
      title: {
        text: 'Ejemplo 1',
        top: 50,
        left: 'center'
    },
    legend: {
      type: 'plain',
      icon: 'circle',
      top: 150
    },
    tooltip: {
      trigger: 'item',
      position: ['35%', '80%']
    },
    series: [
        {
            name: 'Serie de datos 1',
            type: 'pie',
            radius: '55%',
            center: ['50%', '50%'],
            data: [
                {value: 335, name: 'Uno'},
                {value: 310, name: 'Dos'},
                {value: 274, name: 'Tres'},
                {value: 235, name: 'Cuatro'},
                {value: 400, name: 'Cinco'}
            ],
            labelLine: {
                smooth: 0.2,
                length: 10,
                length2: 20
            },
        }
    ]}
  ''',
      ),
    );
  }
}
