import 'package:latlong2/latlong.dart';
import 'package:tien_duong/app/data/models/package_model.dart';

class PointPackage {
  String? type;
  LatLng? latLng;
  String? name;
  int? index;
  Package? package;
  PointPackage({this.type, this.latLng, this.index, this.package, this.name});
}
