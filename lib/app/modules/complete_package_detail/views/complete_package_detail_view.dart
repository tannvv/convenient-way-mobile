import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/modules/complete_package_detail/widgets/header.dart';
import 'package:tien_duong/app/modules/complete_package_detail/widgets/note_info.dart';
import 'package:tien_duong/app/modules/complete_package_detail/widgets/separate.dart';

import '../controllers/complete_package_detail_controller.dart';
import '../widgets/payment_info.dart';
import '../widgets/rating_package.dart';
import '../widgets/transactions_package.dart';
import '../widgets/user_info.dart';
import '../widgets/location_start_end.dart';
import '../widgets/product_info.dart';

class CompletePackageDetailView
    extends GetView<CompletePackageDetailController> {
  const CompletePackageDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderScaffold(
              title: '',
              isBack: true,
            ),
            Expanded(
                child: ListView(
              children: const [
                Header(),
                Separate(),
                UserInfo(),
                Separate(),
                RatingPackage(),
                Separate(),
                LocationStartEnd(),
                Separate(),
                CompleteTransactionsPackage(),
                Separate(),
                ProductInfo(),
                Separate(),
                NoteInfo(),
                Separate(),
                PaymentInfo(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
