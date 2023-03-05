import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tien_duong/app/core/values/app_animation_assets.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';

class CustomOverlay extends StatefulWidget {
  const CustomOverlay({Key? key, this.content = 'Vui lòng chờ...'})
      : super(key: key);
  final String content;

  @override
  State<CustomOverlay> createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(AppAnimationAssets.cuteDancingChicken,
              width: 120.w, height: 120.h),
          Text(
            widget.content,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              textStyle: subtitle2,
            ),
          )
        ],
      ),
    );
  }
}
