import 'package:tien_duong/app/core/base/base_repository.dart';
import 'package:tien_duong/app/data/repository/request_model/vnpay_url_model.dart';
import 'package:tien_duong/app/data/repository/vnpay_req.dart';
import 'package:tien_duong/app/network/dio_provider.dart';

class VnpayReqImp extends BaseRepository implements VnPayReq {
  @override
  Future<String> getVnPayUrl(VnpayUrlModel model) {
    String endpoint = '${DioProvider.baseUrl}/vnpay';
    var dioCall = dioClient.get(endpoint, queryParameters: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        String url = response.data['data'];
        return url;
      });
    } catch (e) {
      rethrow;
    }
  }
}
