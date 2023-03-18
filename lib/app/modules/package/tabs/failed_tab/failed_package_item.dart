// import 'package:tien_duong/app/data/models/package_cancel_model.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:tien_duong/app/modules/sender_package/widgets/user_info.dart';
// import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';
// import '../../widgets/location_start_end.dart';
// import '../../widgets/package_cancel_info.dart';

// class FailedPackageItem extends StatelessWidget {
//   const FailedPackageItem(
//       {Key? key, required this.package, required this.onShowDeliverInfo})
//       : super(key: key);
//   final PackageCancel package;
//   final Function() onShowDeliverInfo;
//   @override
//   Widget build(BuildContext context) {
//     return WrapItem(
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         InkWell(
//             onTap: onShowDeliverInfo,
//             child: UserInfo(info: package.sender!.infoUser!)),
//         LocationStartEnd(
//             locationStart: package.startAddress!,
//             locationEnd: package.destinationAddress!),
//         Gap(12.h),
//         PackageCancelInfo(
//           package: package,
//         ),
//         Gap(12.h),
//       ]),
//     );
//   }
// }
