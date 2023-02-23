import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/data/models/package_cancel_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/package_cancel_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';

class SenderCancelTabItem extends StatelessWidget {
  const SenderCancelTabItem({Key? key, required this.package})
      : super(key: key);
  final PackageCancel package;

  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        LocationStartEnd(
            locationStart: package.startAddress!,
            locationEnd: package.destinationAddress!),
        Gap(12.h),
        PackageCancelInfo(
          package: package,
        ),
        Gap(12.h),
      ]),
    );
  }
}
