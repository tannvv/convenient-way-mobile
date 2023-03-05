class RequestPolylineModel {
  Point? from;
  List<Point>? to;

  RequestPolylineModel({this.from, this.to});

  RequestPolylineModel.fromJson(Map<String, dynamic> json) {
    from = json['from'] != null ? Point?.fromJson(json['from']) : null;
    if (json['to'] != null) {
      to = <Point>[];
      json['to'].forEach((v) {
        to?.add(Point.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (from != null) {
      data['from'] = from?.toJson();
    }
    if (to != null) {
      data['to'] = to?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Point {
  double? longitude;
  double? latitude;

  Point({this.longitude, this.latitude});

  Point.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}