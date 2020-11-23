class AsteroidsModel {
  final Links links;
  final List<NearEarthObjects> nearEarthObjects;

  AsteroidsModel({
    this.links,
    this.nearEarthObjects,
  });

  factory AsteroidsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> nearEarthList = json['near_earth_objects'];
    List<NearEarthObjects> listNearEarthObjects =
        nearEarthList.map((i) => NearEarthObjects.fromJson(i)).toList();

    return AsteroidsModel(
      links: Links.fromJson(json['links']),
      nearEarthObjects: listNearEarthObjects,
    );
  }
}

class Links {
  String next;
  String prev;

  Links({
    this.next,
    this.prev,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      next: json['next'],
      prev: json['prev'],
    );
  }
}

class NearEarthObjects {
  final String id;
  final String nameLimited;
  final bool hazard;
  final List<CloseApproach> closeApproach;
  final AsteroidSize size;

  NearEarthObjects(
      {this.id, this.nameLimited, this.hazard, this.closeApproach, this.size});

  factory NearEarthObjects.fromJson(Map<String, dynamic> json) {
    List<dynamic> listCloseApproachData = json['close_approach_data'];
    List<CloseApproach> listCloseApproach =
        listCloseApproachData.map((i) => CloseApproach.fromJson(i)).toList();

    return NearEarthObjects(
        id: json['id'],
        nameLimited: json['name_limited'],
        hazard: json['is_potentially_hazardous_asteroid'],
        closeApproach: listCloseApproach,
        size: AsteroidSize.fromJson(json['estimated_diameter']));
  }
}

class AsteroidSize {
  final MinMaxDiameter kmDiameter;

  AsteroidSize({this.kmDiameter});

  factory AsteroidSize.fromJson(Map<String, dynamic> json) {
    return AsteroidSize(
        kmDiameter: MinMaxDiameter.fromJson(json['kilometers']));
  }
}

class MinMaxDiameter {
  final int maxDiameter;
  final int minDiameter;

  MinMaxDiameter({this.maxDiameter, this.minDiameter});

  factory MinMaxDiameter.fromJson(Map<int, dynamic> json) {
    return MinMaxDiameter(
        maxDiameter: json['estimated_diameter_min'],
        minDiameter: json['estimated_diameter_min']);
  }
}

class CloseApproach {
  final String closeApproachDate;
  final String closeApproachDateFull;

  CloseApproach({
    this.closeApproachDate,
    this.closeApproachDateFull,
  });

  factory CloseApproach.fromJson(Map<String, dynamic> json) {
    return CloseApproach(
      closeApproachDate: json['close_approach_date'],
      closeApproachDateFull: json['close_approach_date_full'],
    );
  }
}
