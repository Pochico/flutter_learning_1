import 'package:flutter/material.dart';
import 'package:nasa_app/model/rover_mars_model.dart';

class RoverMarsDetail extends StatelessWidget {
  RoverMarsDetail({Key key, @required this.roverItemDetailed})
      : super(key: key);
  final RoverMarsModel roverItemDetailed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image(
            image: NetworkImage(
          roverItemDetailed.imgSrc,
        )),
      ),
    );
  }
}
