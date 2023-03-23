import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/data/models/feedback_model.dart';
import 'package:tien_duong/app/data/models/package_model.dart';

import '../../widgets/rating_info_user.dart';
import '../../widgets/rating_location_start_end.dart';

class ReceiverRatingTabItem extends StatelessWidget {
  const ReceiverRatingTabItem({
    Key? key,
    required this.feedback,
  }) : super(key: key);
  final FeedbackModel feedback;

  @override
  Widget build(BuildContext context) {
    Package package = feedback.package!;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.w),
          boxShadow: ShadowStyles.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: feedback.rating!,
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
              ),
            ],
          ),
          RatingLocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          // )
        ],
      ),
    );
  }
}
