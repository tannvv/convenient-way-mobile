class RoutePoint {
  double? latitude;
  double? longitude;
  int? index;
  String? directionType;
  String? routeId;

  RoutePoint(
      {this.latitude,
      this.longitude,
      this.index,
      this.directionType,
      this.routeId});

  RoutePoint.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    index = json['index'];
    directionType = json['directionType'];
    routeId = json['routeId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['index'] = index;
    data['directionType'] = directionType;
    data['routeId'] = routeId;
    return data;
  }
}
