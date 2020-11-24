import 'package:http/http.dart' as http;
import 'package:nasa_app/model/asteroids_model.dart';
import 'dart:async';
import 'dart:convert';

Future<AsteroidsModel> fetchAsteroids(
    int page, String fecha, String fechaFin) async {
  final response = await http.get(
      'http://www.neowsapp.com/rest/v1/neo/browse?page=$page&start_date=$fecha&end_date=$fechaFin&size=10&api_key=HcGWTXWUhVT7HsEI9OkttaomUjyHHGP6ChRGUCne');

  if (response.statusCode == 200) {
    AsteroidsModel respuesta =
        AsteroidsModel.fromJson(jsonDecode(response.body));

    return respuesta;
  } else {
    throw Exception('Failed to load Asteroids');
  }
}
