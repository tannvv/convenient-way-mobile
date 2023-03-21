import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';

import '../controllers/complete_package_detail_controller.dart';

class UserInfo extends GetWidget<CompletePackageDetailController> {
  const UserInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      highlightColor: Colors.black.withOpacity(0.08),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 44.w,
              height: 44.h,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(18.r), // Image radius
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(),
                    fadeOutDuration: const Duration(),
                    placeholder: (context, url) {
                      return controller.sender?.gender == 'FEMALE'
                          ? SvgPicture.asset(AppAssets.female)
                          : SvgPicture.asset(AppAssets.male);
                    },
                    imageUrl: controller.sender?.photoUrl ?? '-',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return controller.sender?.gender == 'FEMALE'
                          ? SvgPicture.asset(AppAssets.female)
                          : SvgPicture.asset(AppAssets.male);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              '${controller.sender?.firstName} ${controller.sender?.lastName}',
              style: subtitle1.copyWith(
                fontWeight: FontWeights.bold,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
