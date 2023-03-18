import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class PolylineModel {
  String? id;
  double? distance;
  double? time;
  String? fromName;
  String? toName;
  LatLng? from;
  LatLng? to;
  List<LatLng>? polyPoints;

  PolylineModel(
      {this.distance,
      this.time,
      this.fromName,
      this.toName,
      this.from,
      this.to,
      this.polyPoints});

  PolylineModel.fromJson(Map<String, dynamic> json) {
    id = const Uuid().v4();
    distance = json['distance'];
    time = json['time'];
    fromName = json['fromName'];
    toName = json['toName'];
    from = json['from'] != null
        ? LatLng(json['from']['latitude'], json['from']['longitude'])
        : null;
    to = json['to'] != null
        ? LatLng(json['to']['latitude'], json['to']['longitude'])
        : null;
    if (json['polyPoints'] != null) {
      polyPoints = <LatLng>[];
      json['polyPoints'].forEach((v) {
        polyPoints?.add(LatLng(v['latitude'], v['longitude']));
      });
    }
  }
}
