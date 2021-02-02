import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Colores APP
Color primaryColor = Colors.red; //Color(0xFF17161b);
Color primaryColorShade = Colors.red; //Color(0xFF242C2F);
Color secondaryColor = Colors.red; //Color(0xFFf2c902);
Color buttonColor;

Future<void> setTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final darkTheme = prefs.getBool('is_dark_theme');
  if (darkTheme == true) {
    primaryColor = Color(0xFF17161b);
    primaryColorShade = Color(0xFF242C2F);
    secondaryColor = Color(0xFFf2c902);
    buttonColor = primaryColor;
  } else {
    primaryColor = Color(0xFFFFCC66);
    primaryColorShade = Color(0xFFb1cdce);
    secondaryColor = Color(0xFF17161b);
    buttonColor = primaryColor;
  }
}

// Colores gráfica Asteroides
const ASTEROID_COLOR_1 = Color(0xFF6FACC8);
const ASTEROID_COLOR_2 = Color(0xFF3862C4);
const ASTEROID_COLOR_3 = Color(0xFF2D5B6B);
const ASTEROID_COLOR_4 = Color(0xFF1E7958);
const ASTEROID_COLOR_5 = Color(0xFF3B7125);
const ASTEROID_COLOR_6 = Color(0xFF7B7D2A);
const ASTEROID_COLOR_7 = Color(0xFFD88A83);
const ASTEROID_COLOR_8 = Color(0xFFffa62b);
const ASTEROID_COLOR_9 = Color(0xFFdb6400);
const ASTEROID_COLOR_10 = Color(0xFFbd443b);

// Estilos dialog asteroides
const FONT_SIZE = 16.0;
const FONT_WEIGHT = FontWeight.bold;

// TODO hacer pantalla setings Con el switch de los colores para cambiar el tema.
// TODO filtro camaras rover de marte.
