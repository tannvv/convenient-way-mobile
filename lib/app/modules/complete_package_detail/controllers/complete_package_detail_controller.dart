import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart%20%20';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/data/constants/package_status.dart';
import 'package:tien_duong/app/data/constants/role_name.dart';
import 'package:tien_duong/app/data/models/feedback_model.dart';
import 'package:tien_duong/app/data/models/info_user_model.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/product_model.dart';
import 'package:tien_duong/app/data/models/transaction_package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/package_model/feedback_list_model.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

class CompletePackageDetailController extends BaseController {
  Package package = Get.arguments as Package;

  final horizontalPadding = 20.w;
  final widthSeparateTransaction = 90.w;
  late String createAt;
  late String totalPriceProducts;
  late String totalPrice;
  late List<Product> products;
  Rx<double> rating = 0.0.obs;
  InfoUser? deliver;
  InfoUser? sender;
  List<TransactionPackage> transactionPackages = [];

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() {
    fetchFeedback();
    createAt = DateTimeUtils.dateTimeToString(package.createdAt);
    deliver = package.deliver?.infoUser;
    sender = package.sender?.infoUser;
    products = package.products ?? [];
    transactionPackages = [...package.transactionPackages!];
    transactionPackages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    // package.transactionPackages!
    //     .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    // transactionPackages = package.transactionPackages!;
    transactionPackages
        .removeWhere((element) => element.toStatus == PackageStatus.SUCCESS);

    int total = 0;
    for (var element in products) {
      total += element.price!;
    }
    totalPrice = (total + package.priceShip!).toVND();
    totalPriceProducts = total.toVND();
  }

  String getLabel(String packageStatus) {
    if (packageStatus == PackageStatus.WAITING) {
      return 'Chờ xác nhận';
    } else if (packageStatus == PackageStatus.APPROVED) {
      return 'Đã xác nhận';
    } else if (packageStatus == PackageStatus.SELECTED) {
      return 'Chờ lấy hàng';
    } else if (packageStatus == PackageStatus.PICKUP_SUCCESS) {
      return 'Chờ giao hàng';
    } else if (packageStatus == PackageStatus.DELIVERED_SUCCESS) {
      return 'Giao hàng thành công';
    }
    return '-';
  }

  Future<void> gotoRatingPage(double value) async {
    double? result = await Get.toNamed(Routes.FEEDBACK_FOR_DELIVER, arguments: {
      'package': package,
      'initRating': value,
    }) as double?;
  }

  Future<void> fetchFeedback() async {
    FeedbackListModel feedbackListModel =
        FeedbackListModel(packageId: package.id, feedbackFor: RoleName.sender);
    var future = _packageRepo.getFeedback(feedbackListModel);
    await callDataService<List<Feedback>>(future, onSuccess: (data) {
      if (data.isNotEmpty) {
        rating.value = data[0].rating ?? 0;
      }
    }, onError: showError);
  }
}
