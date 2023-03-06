import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/package_model.dart';

class PackageInfo extends StatelessWidget {
  const PackageInfo(
      {super.key, required this.package, this.isShowPrice = false});
  final Package package;
  final bool isShowPrice;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Tên người nhận: '),
            Text(
              '${package.receiverName}',
              style: subtitle2,
            ),
          ],
        ),
        Gap(4.h),
        Row(
          children: [
            const Text('Sản phẩm: '),
            Expanded(
              child: Text(
                package.getProductNames(),
                style: subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Gap(4.h),
        Row(
          children: [
            const Text('Phí vận chuyển: '),
            Text(
              package.priceShip?.toVND() ?? '',
              style: subtitle2,
            ),
          ],
        ),
        isShowPrice
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(4.h),
                  Row(
                    children: [
                      const Text('Số tiền cọc: '),
                      Text(
                        package.getTotalPrice().toVND(),
                        style: subtitle2,
                      ),
                    ],
                  ),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
