import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/info_user_model.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, required this.info}) : super(key: key);
  final InfoUser info;
  @override
  Widget build(BuildContext context) {
    String? fname = info.firstName;
    String? lname = info.lastName;
    return Row(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$fname $lname',
              style: subtitle1.copyWith(
                fontWeight: FontWeights.medium,
                color: Colors.black54,
              ),
            ),
            Gap(2.h),
            Text(
              info.phone ?? '-',
              style: subtitle2.copyWith(
                fontWeight: FontWeights.regular ,
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }
}
