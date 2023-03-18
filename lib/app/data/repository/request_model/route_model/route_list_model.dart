import 'package:tien_duong/app/data/models/route_point_model.dart';

class RouteListModel {
  String? routeId;
  List<RoutePoint>? forwardPoints;
  List<RoutePoint>? backwardPoints;

  RouteListModel({this.routeId, this.forwardPoints, this.backwardPoints});

  RouteListModel.fromJson(Map<String, dynamic> json) {
    routeId = json['routeId'];
    if (json['forwardPoints'] != null) {
      forwardPoints = <RoutePoint>[];
      json['forwardPoints'].forEach((v) {
        forwardPoints!.add(RoutePoint.fromJson(v));
      });
    }
    if (json['backwardPoints'] != null) {
      backwardPoints = <RoutePoint>[];
      json['backwardPoints'].forEach((v) {
        backwardPoints!.add(RoutePoint.fromJson(v));
      });
    }
  }
}
