import 'package:tien_duong/app/core/base/base_repository.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/network/dio_provider.dart';

class GoongReqImp extends BaseRepository implements GoongReq {
  @override
  Future<List<ResponseGoong>> getList(String query) {
    String endpoint = '${DioProvider.baseUrl}/goongs';
    var dioCall = dioClient.get(endpoint, queryParameters: {'search': query});
    try {
      return callApi(dioCall).then((response) {
        List<ResponseGoong> data = (response.data['data'] as List)
            .map((e) => ResponseGoong.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }
}
