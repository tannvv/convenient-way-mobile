import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_paging_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/constants/role_name.dart';
import 'package:tien_duong/app/data/models/feedback_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_model/feedback_list_model.dart';

class CreatorRatingTabController extends BasePagingController<FeedbackModel> {
  final AuthController _authController = Get.find<AuthController>();

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  @override
  Future<void> fetchDataApi() async {
    FeedbackListModel model = FeedbackListModel(
        creatorId: _authController.account!.id!,
        feedbackFor: RoleName.sender,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<FeedbackModel>> future = _packageRepo.getFeedback(model);
    await callDataService<List<FeedbackModel>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}
