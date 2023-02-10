import 'package:tien_duong/app/data/models/response_goong_model.dart';

abstract class GoongReq {
  Future<List<ResponseGoong>> getList(String query);
}
