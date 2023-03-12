import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/user_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';

class DeliveryFailedTabItem extends StatelessWidget {
  const DeliveryFailedTabItem(
      {Key? key, required this.package, required this.showInfoDeliver})
      : super(key: key);
  final Package package;
  final Function() showInfoDeliver;
  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(
            info: package.deliver!.infoUser!,
            onTap: showInfoDeliver,
          ),
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(package: package),
          Gap(12.h),
        ],
      ),
    );
  }
}
