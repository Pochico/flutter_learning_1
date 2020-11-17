import 'package:http/http.dart' as http;
import 'package:nasa_app/model/pic_of_day_model.dart';
import 'dart:async';
import 'dart:convert';

Future<PicOfDayModel> fetchAlbum(String fecha) async {
  final response = await http.get(
      'https://api.nasa.gov/planetary/apod?date=$fecha&api_key=HcGWTXWUhVT7HsEI9OkttaomUjyHHGP6ChRGUCne');
  // Aplicar date=&

  if (response.statusCode == 200) {
    var respuesta = PicOfDayModel.fromJson(jsonDecode(response.body));
    return respuesta;
  } else {
    throw Exception('Failed to load album');
  }
}
