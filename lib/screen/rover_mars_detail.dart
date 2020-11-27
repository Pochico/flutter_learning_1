import 'package:flutter/material.dart';
import 'package:nasa_app/model/rover_mars_model.dart';

class RoverMarsDetail extends StatelessWidget {
  RoverMarsDetail({Key key, @required this.roverItemDetailed})
      : super(key: key);
  final RoverMarsModel roverItemDetailed;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(children: [
          SizedBox(height: 20),
          Hero(
            tag: roverItemDetailed.imgSrc,
            child: Image.network(
              roverItemDetailed.imgSrc,
            ),
          ),
          SizedBox(height: 20),
          Text(
            roverItemDetailed.earthDate,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              roverItemDetailed.camera.fullName,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          )
        ]),
      ),
    );
  }
}
