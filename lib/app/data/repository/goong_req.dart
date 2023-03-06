import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/models/polyline_model.dart';
import 'package:tien_duong/app/data/repository/request_model/request_polyline_model';

abstract class GoongReq {
  Future<List<ResponseGoong>> getList(String query);
  Future<List<PolylineModel>> getPolyline(RequestPolylineModel model);
}
