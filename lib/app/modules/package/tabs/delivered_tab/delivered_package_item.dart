import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';

class DeliveredPackageItem extends StatelessWidget {
  const DeliveredPackageItem({Key? key, required this.package})
      : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Điểm đến: ${package.destinationAddress}.',
          style: subtitle2,
        ),
        Text(
          'Người nhận: ${package.receiverName}.',
          style: subtitle2,
        ),
        Text(
          'Số điện thoại: ${package.receiverPhone}.',
          style: subtitle2,
        )
      ],
    );
  }
}