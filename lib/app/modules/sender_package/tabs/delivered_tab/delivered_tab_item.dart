import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/location_start_end.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/package_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/user_info.dart';
import 'package:tien_duong/app/modules/sender_package/widgets/wrap_item.dart';

class DeliveredTabItem extends StatelessWidget {
  const DeliveredTabItem(
      {Key? key,
      required this.package,
      required this.onConfirmSuccess,
      required this.onConfirmFailed,
      required this.showInfoDeliver})
      : super(key: key);
  final Package package;
  final Function() onConfirmSuccess;
  final Function() onConfirmFailed;
  final Function() showInfoDeliver;
  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfo(info: package.deliver!.infoUser!, onTap: showInfoDeliver),
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(package: package),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                'Chưa nhận',
                icon: Icons.sms_failed,
                onPressed: onConfirmFailed,
                backgroundColor: Colors.red[700]!,
                textColor: Colors.red[700]!,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              ),
              Gap(8.w),
              ColorButton(
                'Đã nhận',
                icon: Icons.check,
                onPressed: onConfirmSuccess,
                backgroundColor: const Color.fromARGB(255, 7, 202, 30),
                textColor: const Color.fromARGB(255, 7, 202, 30),
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
