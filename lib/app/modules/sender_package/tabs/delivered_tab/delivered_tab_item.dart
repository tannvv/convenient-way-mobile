import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
      required this.onSendFeedbackDriver,
      required this.showInfoDeliver,
      this.onPressedDetail})
      : super(key: key);
  final Package package;
  final Function() onConfirmSuccess;
  final Function() onConfirmFailed;
  final Function() showInfoDeliver;
  final Function() onSendFeedbackDriver;
  final Function()? onPressedDetail;
  @override
  Widget build(BuildContext context) {
    return WrapItem(
      onPressedDetail: onPressedDetail,
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
                'Báo có vấn đề',
                icon: Icons.sms_failed,
                onPressed: onConfirmFailed,
                backgroundColor: Colors.red[700]!,
                textColor: Colors.red[700]!,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                'Gửi đánh giá',
                icon: Icons.star,
                onPressed: onSendFeedbackDriver,
                backgroundColor: Colors.yellow,
                textColor: Colors.amber[800]!,
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
