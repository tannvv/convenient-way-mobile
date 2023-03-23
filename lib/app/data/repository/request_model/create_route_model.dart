import 'package:tien_duong/app/data/models/route_model.dart';
import 'package:tien_duong/app/data/repository/request_model/route_model/create_route_point_model.dart';

class CreateRoute {
  String? fromName;
  double? fromLongitude;
  double? fromLatitude;
  String? toName;
  double? toLongitude;
  double? toLatitude;
  double? distanceForward;
  double? distanceBackward;
  String? accountId;
  List<CreateRoutePointModel>? routePoints;

  CreateRoute(
      {this.fromName,
      this.fromLongitude,
      this.fromLatitude,
      this.toName,
      this.toLongitude,
      this.toLatitude,
      this.distanceForward,
      this.distanceBackward,
      this.routePoints,
      this.accountId});

  CreateRoute.fromJson(Map<String, dynamic> json) {
    fromName = json['fromName'];
    fromLongitude = json['fromLongitude'];
    fromLatitude = json['fromLatitude'];
    toName = json['toName'];
    toLongitude = json['toLongitude'];
    toLatitude = json['toLatitude'];
    distanceForward = json['distanceForward'];
    distanceBackward = json['distanceBackward'];
    accountId = json['accountId'];
    if (json['routePoints'] != null) {
      routePoints = <CreateRoutePointModel>[];
      json['routePoints'].forEach((v) {
        routePoints!.add(CreateRoutePointModel.fromJson(v));
      });
    }
  }

  static fromRoute(RouteAcc route, String accountId) {
    return CreateRoute(
        fromName: route.fromName,
        fromLongitude: route.fromLongitude,
        fromLatitude: route.fromLatitude,
        toName: route.toName,
        toLongitude: route.toLongitude,
        toLatitude: route.toLatitude,
        accountId: accountId);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromName'] = fromName;
    data['fromLongitude'] = fromLongitude;
    data['fromLatitude'] = fromLatitude;
    data['toName'] = toName;
    data['toLongitude'] = toLongitude;
    data['toLatitude'] = toLatitude;
    data['distanceForward'] = distanceForward;
    data['distanceBackward'] = distanceBackward;
    data['accountId'] = accountId;
    if (routePoints != null) {
      data['routePoints'] = routePoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
