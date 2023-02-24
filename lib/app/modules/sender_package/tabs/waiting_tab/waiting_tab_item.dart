import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';

import '../../widgets/location_start_end.dart';
import '../../widgets/package_info.dart';

class WaitingTabItem extends StatelessWidget {
  const WaitingTabItem(
      {Key? key, required this.package, required this.onCancelPackage})
      : super(key: key);
  final Package package;
  final Function() onCancelPackage;
  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(
            package: package,
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                'Hủy',
                icon: Icons.delete,
                onPressed: onCancelPackage,
                backgroundColor: Colors.red,
                textColor: Colors.red,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              )
            ],
          )
        ],
      ),
    );
  }
}
