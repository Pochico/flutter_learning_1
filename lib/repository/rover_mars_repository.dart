import 'package:http/http.dart' as http;
import 'package:nasa_app/model/rover_mars_model.dart';
import 'dart:async';
import 'dart:convert';

Future<List<RoverMarsModel>> fetchPhotoRovers() async {
  var date = "2016-6-3";
  final response = await http.get(
      'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=$date&api_key=HcGWTXWUhVT7HsEI9OkttaomUjyHHGP6ChRGUCne');

  if (response.statusCode == 200) {
    List<dynamic> respuesta = jsonDecode(response.body)['photos'];
    var roverList =
        respuesta.map((item) => RoverMarsModel.fromJson(item)).toList();

    return roverList;
  } else {
    throw Exception('Failed to load Rover');
  }
}
