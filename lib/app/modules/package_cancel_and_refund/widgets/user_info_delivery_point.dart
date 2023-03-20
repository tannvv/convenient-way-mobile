import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/app_assets.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/package_model.dart';

class UserInfoDeliveryPoint extends StatelessWidget {
  const UserInfoDeliveryPoint({Key? key, required this.package})
      : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    bool isSender = package.sender?.infoUser?.phone == package.pickupPhone;
    String? name = package.receiverName;
    String? phone = package.receiverPhone;
    return Row(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(18.r), // Image radius
            child: isSender
                ? CachedNetworkImage(
                    fadeInDuration: const Duration(),
                    fadeOutDuration: const Duration(),
                    placeholder: (context, url) {
                      return SvgPicture.asset(AppAssets.male);
                    },
                    imageUrl: package.sender?.infoUser?.photoUrl ?? '-',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return SvgPicture.asset(AppAssets.male);
                    },
                  )
                : SvgPicture.asset(AppAssets.male),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? '-',
              style: subtitle1.copyWith(
                fontWeight: FontWeights.medium,
                color: Colors.black54,
              ),
            ),
            Gap(2.h),
            Text(
              phone ?? '-',
              style: subtitle2.copyWith(
                fontWeight: FontWeights.regular,
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }
}
