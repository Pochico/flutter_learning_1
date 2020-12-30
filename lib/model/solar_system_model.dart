import 'package:flutter/material.dart';

class SolarSystemModel {
  final List<PlanetModel> solarSystem;

  SolarSystemModel({this.solarSystem});

  factory SolarSystemModel.fromJson(List<dynamic> parsedJson) {
    List<PlanetModel> solarSystem = new List<PlanetModel>();
    solarSystem = parsedJson.map((i) => PlanetModel.fromJson(i)).toList();
    return new SolarSystemModel(solarSystem: solarSystem);
  }
}

class PlanetModel {
  final int id;
  final String name;
  final String mass;
  final int diameter;
  final int density;
  final String gravity;
  final String dayLength;
  final String sunDistance;
  final String orbitalPeriod;
  final int moonsCount;

  PlanetModel(
      {this.id,
      this.name,
      this.mass,
      this.diameter,
      this.density,
      this.gravity,
      this.dayLength,
      this.sunDistance,
      this.orbitalPeriod,
      this.moonsCount});

  factory PlanetModel.fromJson(Map<String, dynamic> json) {
    return PlanetModel(
        id: json['id'],
        name: json['name'],
        mass: json['mass'],
        diameter: json['diameter'],
        density: json['density'],
        gravity: json['gravity'],
        dayLength: json['length_of_day'],
        sunDistance: json['distance_from_sun'],
        orbitalPeriod: json['orbital_period'],
        moonsCount: json['number_of_moons']);
  }
}
