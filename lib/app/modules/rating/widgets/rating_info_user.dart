import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/info_user_model.dart';
import 'package:tien_duong/app/modules/rating/controllers/rating_controller.dart';

class RatingUserInfo extends GetWidget<RatingController> {
  const RatingUserInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    InfoUser info = controller.userInfo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      child: Column(
        children: [
          Row(
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(18.r), // Image radius
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(),
                    fadeOutDuration: const Duration(),
                    placeholder: (context, url) {
                      return info.gender == 'FEMALE'
                          ? SvgPicture.asset(AppAssets.female)
                          : SvgPicture.asset(AppAssets.male);
                    },
                    imageUrl: info.photoUrl ?? '-',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return info.gender == 'FEMALE'
                          ? SvgPicture.asset(AppAssets.female)
                          : SvgPicture.asset(AppAssets.male);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                '${info.firstName} ${info.lastName}',
                style: subtitle1.copyWith(
                  fontWeight: FontWeights.medium,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Gap(20.h),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Tổng số đánh giá: ${controller.accountRating.value?.totalRatingDeliver ?? 0}'),
                  RatingBar.builder(
                    initialRating:
                        controller.accountRating.value?.averageRatingDeliver ??
                            0,
                    ignoreGestures: true,
                    minRating: 0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    itemSize: 24.sp,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 8.sp,
                    ),
                    onRatingUpdate: (value) {},
                  )
                ],
              ))
        ],
      ),
    );
  }
}
