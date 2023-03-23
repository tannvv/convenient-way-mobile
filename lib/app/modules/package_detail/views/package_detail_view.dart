import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/header.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/note_info.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/separate.dart';
import '../controllers/package_detail_controller.dart';
import '../widgets/payment_info.dart';
import '../widgets/user_info.dart';
import '../widgets/location_start_end.dart';
import '../widgets/product_info.dart';

class PackageDetailView extends GetView<PackageDetailController> {
  const PackageDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: const [
            HeaderScaffold(
              title: '',
              isBack: true,
            ),
            Header(),
            Separate(),
            UserInfo(),
            Separate(),
            LocationStartEnd(),
            Separate(),
            ProductInfo(),
            Separate(),
            NoteInfo(),
            Separate(),
            PaymentInfo(),
          ],
        ),
      ),
    );
  }
}
