import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tien_duong/app/modules/feedback_for_deliver/controllers/feedback_for_deliver_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Stars extends GetView<FeedbackForDeliverController> {
  const Stars({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: controller.initRating ?? 0,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: controller.changePoint,
    );
  }
}
