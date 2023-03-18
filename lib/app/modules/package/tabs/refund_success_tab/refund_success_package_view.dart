// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:tien_duong/app/core/widgets/custom_footer_smart_refresh.dart';
// import 'package:tien_duong/app/modules/package/tabs/refund_success_tab/refund_success_package_controller.dart';
// import 'package:tien_duong/app/modules/package/tabs/refund_success_tab/refund_success_package_item.dart';

// class RefundSuccessPackageView extends GetView<RefundSuccessPackageController> {
//   const RefundSuccessPackageView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(10),
//         child: Obx(() => SmartRefresher(
//               controller: controller.refreshController,
//               onRefresh: () => controller.onRefresh(),
//               onLoading: () => controller.onLoading(),
//               footer: CustomFooterSmartRefresh.defaultCustom(),
//               child: ListView.separated(
//                   itemBuilder: (_, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         RefundSuccessPackageItem(
//                             package: controller.dataApis[index]),
//                       ],
//                     );
//                   },
//                   separatorBuilder: (_, index) => Gap(12.h),
//                   itemCount: controller.dataApis.length),
//             )));
//   }
// }
