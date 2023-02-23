import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';

import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyScaffold(header: _header(), body: _body(context)),
    );
  }

  Widget _header() {
    return const HeaderScaffold(
      title: 'Xác thực OTP',
      isBack: true,
    );
  }

  Padding _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Chúng tôi đã gửi OTP đến SĐT: ",
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: controller.phone,
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: "\nNhập OTP để tiếp tục!",
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: ShadowStyles.primary,
                borderRadius: BorderRadius.circular(10.r)),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) {},
              pinTheme: PinTheme(
                activeColor: AppColors.blue,
                selectedColor: AppColors.blue,
                inactiveColor: Colors.black26,
              ),
              onCompleted: (String value) {
                controller.verifyOTP(value);
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Bạn chưa nhận được OTP? ",
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
                WidgetSpan(
                    child: Obx(
                  () => controller.isLoadingResend.value
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          height: 16.sp,
                          width: 16.sp,
                          child: const CircularProgressIndicator())
                      : const SizedBox(),
                )),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      controller.resendOTP();
                    },
                    child: Text(
                      "Gửi lại",
                      style: GoogleFonts.montserrat(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
