class CreateRoutePointModel {
  double? latitude;
  double? longitude;
  int? index;
  String? directionType;

  CreateRoutePointModel(
      {this.latitude, this.longitude, this.index, this.directionType});

  CreateRoutePointModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    index = json['index'];
    directionType = json['directionType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['index'] = index;
    data['directionType'] = directionType;
    return data;
  }
}

class DirectionType {
  static const String forward = 'FORWARD';
  static const String backward = 'BACKWARD';
  static const String both = 'TWO_WAY';
}
