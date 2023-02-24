import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';

class RejectTabItem extends StatelessWidget {
  const RejectTabItem({Key? key, required this.package}) : super(key: key);
  final Package package;

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
          PackageInfo(package: package),
          Gap(12.h),
        ],
      ),
    );
  }
}
