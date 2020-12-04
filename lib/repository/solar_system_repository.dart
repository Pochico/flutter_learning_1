import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nasa_app/model/solar_system_model.dart';

Future<SolarSystemModel> fetchSolarSystem() async {
  final response =
      await http.get('https://dry-plains-91502.herokuapp.com/planets');

  if (response.statusCode == 200) {
    SolarSystemModel respuesta =
        SolarSystemModel.fromJson(jsonDecode(response.body));
    return respuesta;
  } else {
    throw Exception('Failed to load Asteroids');
  }
}
