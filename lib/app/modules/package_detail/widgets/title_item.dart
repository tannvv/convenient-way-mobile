import 'package:flutter/material.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: subtitle2.copyWith(
          fontWeight: FontWeight.bold, color: Colors.grey[500]),
    );
  }
}
