import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/data/models/transaction_model.dart';
import 'package:tien_duong/app/data/repository/request_model/transaction_list_model.dart';
import 'package:tien_duong/app/data/repository/transaction_req.dart';

class TransactionController extends BasePagingController<Transaction> {
  final AuthController _authController = Get.find<AuthController>();
  final TransactionReq _transactionRepo =
      Get.find(tag: (TransactionReq).toString());

  @override
  Future<void> fetchDataApi() async {
    String accountId = _authController.account!.id!;
    TransactionListModel model = TransactionListModel(
        accountId: accountId, pageIndex: pageIndex, pageSize: pageSize);
    Future<List<Transaction>> future = _transactionRepo.getList(model);
    await callDataService<List<Transaction>>(future, onSuccess: (response) {
      super.onSuccess(response);
      bool flag = false;
      for (Transaction item in dataApis) {
        if (DateTimeUtils.compare(item.createdAt, DateTime.now()) &&
            flag == false) {
          item.filter = 0;
          flag = true;
        } else if (!DateTimeUtils.compare(item.createdAt, DateTime.now()) &&
            flag == true) {
          item.filter = 1;
          break;
        }
      }
    }, onError: onError);
  }
}
