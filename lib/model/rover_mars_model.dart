class RoverMarsModel {
  final int id;
  final int sol;
  final String imgSrc;
  final String earthDate;
  final Camera camera;

  RoverMarsModel({
    this.id,
    this.sol,
    this.imgSrc,
    this.earthDate,
    this.camera,
  });

  factory RoverMarsModel.fromJson(Map<String, dynamic> json) {
    return RoverMarsModel(
      id: json['id'],
      sol: json['sol'],
      imgSrc: json['img_src'],
      earthDate: json['earth_date'],
      camera: Camera.fromJson(json['camera']),
    );
  }
}

class Camera {
  final int id;
  final String fullName;
  final int roverId;

  Camera({
    this.id,
    this.fullName,
    this.roverId,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'] as int,
      fullName: json['full_name'],
      roverId: json['rover_id'] as int,
    );
  }
}
