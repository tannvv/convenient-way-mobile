import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/product_model.dart';
import 'package:tien_duong/app/modules/package_detail/controllers/package_detail_controller.dart';
import 'package:tien_duong/app/modules/package_detail/widgets/title_item.dart';

class ProductInfo extends GetWidget<PackageDetailController> {
  const ProductInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: controller.horizontalPadding, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleItem(title: 'Các sản phẩm'),
          Gap(14.h),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final product = controller.products[index];
                return _productItem(product);
              },
              separatorBuilder: (_, __) => Gap(8.h),
              itemCount: controller.products.length)
        ],
      ),
    );
  }

  Widget _productItem(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '${product.name}',
                style: subtitle2.copyWith(
                    fontWeight: FontWeight.w500, color: AppColors.description),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              product.price.toVND(),
              style: subtitle2.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.description),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        Text(
          '${product.description}',
          style: subtitle2.copyWith(
              fontWeight: FontWeight.w500, color: AppColors.description),
          overflow: TextOverflow.ellipsis,
        ),
        Gap(4.h),
      ],
    );
  }
}
