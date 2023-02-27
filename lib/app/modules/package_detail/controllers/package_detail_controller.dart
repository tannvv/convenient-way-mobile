import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart%20%20';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/utils/datetime_utils.dart';
import 'package:tien_duong/app/data/models/info_user_model.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/product_model.dart';

class PackageDetailController extends BaseController {
  Package package = Get.arguments as Package;

  final horizontalPadding = 20.w;
  late String createAt;
  late String totalPriceProducts;
  late String totalPrice;
  late List<Product> products;
  InfoUser? deliver;
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  initData() {
    createAt = DateTimeUtils.dateTimeToString(package.createdAt);
    deliver = package.deliver?.infoUser;
    products = package.products ?? [];

    int total = 0;
    for (var element in products) {
      total += element.price!;
    }
    totalPrice = (total + package.priceShip!).toVND();
    totalPriceProducts = total.toVND();
  }
}
