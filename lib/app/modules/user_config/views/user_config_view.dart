import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/modules/user_config/widgets/active_suggest.dart';
import 'package:tien_duong/app/modules/user_config/widgets/direction_suggest.dart';
import 'package:tien_duong/app/modules/user_config/widgets/distance_package.dart';
import 'package:tien_duong/app/modules/user_config/widgets/warning_price.dart';

import '../controllers/user_config_controller.dart';

class UserConfigView extends GetView<UserConfigController> {
  const UserConfigView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomBodyScaffold(header: _header(), body: _body()),
    );
  }

  Widget _header() {
    return const HeaderScaffold(
      title: 'Thông tin cấu hình',
      isBack: true,
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      children: [
        const ActiveSuggest(),
        SizedBox(height: 16.h),
        const WarningPriceForm(),
        SizedBox(height: 16.h),
        const DistancePackageForm(),
        SizedBox(height: 16.h),
        const DirectionSuggestForm(),
      ],
    );
  }
}
