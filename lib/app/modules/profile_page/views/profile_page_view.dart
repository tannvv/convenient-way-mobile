import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/data/options/gender_option.dart';
import 'package:tien_duong/app/modules/profile_page/widgets/avatart_name_profile.dart';
import 'package:tien_duong/app/modules/profile_page/widgets/card_item.dart';
import 'package:tien_duong/app/modules/profile_page/widgets/phone_number_profile.dart';
import 'package:tien_duong/app/modules/profile_page/widgets/wallet_profile.dart';
import 'package:tien_duong/app/routes/app_pages.dart';
import '../controllers/profile_page_controller.dart';
import '../widgets/my_package.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageView({Key? key}) : super(key: key);

  final double paddingLeft = 30.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          const HeaderScaffold(title: 'Tài khoản của tôi'),
          const Padding(
            padding: EdgeInsets.all(12),
            child: AvatarNameProfile(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: WalletProfile(),
          ),
          Gap(12.h),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: MyPackage(),
          ),
          Padding(
            padding: EdgeInsets.only(left: paddingLeft, top: 10),
            child: Column(
              children: [
                // _separateContent(),
                // const PhoneNumberProfile(),
                // _separateContent(),
                // _gender(),
                // _separateContent(),
                // _email(),
                _separateContent(),
              ],
            ),
          ),
          _manage(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: IconsOutlineButton(
              onPressed: controller.signOut,
              text: 'Đăng xuất',
              iconData: Icons.offline_share,
              textStyle: subtitle2.copyWith(
                color: AppColors.primary800,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: Colors.black12.withOpacity(0.06),
            ),
          )
        ],
      ),
    );
  }

  Divider _separateContent() {
    return Divider(
      endIndent: 0,
      thickness: 2,
      color: Colors.black.withOpacity(0.08),
    );
  }

  Widget _manage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: paddingLeft),
          child: Text(
            'Quản lí',
            style: body2.copyWith(color: AppColors.gray),
          ),
        ),
        Gap(8.h),
        CardItem(
            icon: Icons.person,
            text: 'Thông tin cá nhân',
            color: AppColors.hardBlue,
            onPress: () {}),
        CardItem(
            icon: Icons.star,
            text: 'Đánh giá của tôi',
            color: AppColors.yellow,
            onPress: () {}),
        CardItem(
            icon: Icons.alt_route_outlined,
            text: 'Các lộ trình thiết lập',
            color: AppColors.softGreen,
            onPress: () {
              Get.toNamed(Routes.MANAGE_ROUTE);
            }),
        CardItem(
            icon: Icons.settings,
            text: 'Thông tin cấu hình',
            color: AppColors.gray,
            onPress: () {
              Get.toNamed(Routes.USER_CONFIG);
            }),
      ],
    );
  }

  Column _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Địa chỉ email',
          style: body2.copyWith(color: AppColors.floatLabel),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 44.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 3,
                  child: Text(
                    controller.initEmail,
                    style: subtitle1.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.softBlack,
                      fontWeight: FontWeights.medium,
                    ),
                  )),
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 6),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.yellow)),
                        onPressed: null,
                        child: Text(
                          'Đã kết nối',
                          style: subtitle2,
                        )),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Column _gender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Giới tính',
          style: body2.copyWith(color: AppColors.floatLabel),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Flexible(
                flex: 30,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24))),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: DropdownButton(
                        style: subtitle2,
                        icon: const Icon(Icons.arrow_downward_outlined),
                        menuMaxHeight: Get.height * 0.4,
                        iconSize: 24,
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        items: GenderOption.getOptionDropdown(),
                        value: controller.initGender,
                        onChanged: (selectedValue) async {},
                      ),
                    ),
                  ),
                )),
            const Flexible(
                child: SizedBox(
              width: 40,
            )),
          ],
        ),
      ],
    );
  }
}
