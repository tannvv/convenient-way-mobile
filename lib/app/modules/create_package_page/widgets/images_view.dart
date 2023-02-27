import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';

import 'image_card.dart';

class ImagesView extends GetWidget<CreatePackagePageController> {
  const ImagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hình ảnh', style: header),
        Gap(8.h),
        MultiImagePickerView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          onChange: (list) {
            controller.images = list;
          },
          itemBuilder: (context, file, deleteCallback) {
            return ImageCard(file: file, deleteCallback: deleteCallback);
          },
          initialContainerBuilder: (context, pickerCallback) {
            return TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 16.sp,
                    ),
                    Gap(4.w),
                    Text(
                      'Thêm hình ảnh',
                      style: subtitle2.copyWith(color: Colors.blue),
                    )
                  ],
                ),
              ),
              onPressed: () {
                pickerCallback();
              },
            );
          },
          addMoreBuilder: (context, pickerCallback) {
            return SizedBox(
              height: 170.h,
              width: double.infinity,
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    shape: const CircleBorder(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: const Icon(
                      Icons.add,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  onPressed: () {
                    pickerCallback();
                  },
                ),
              ),
            );
          },
          controller: controller.imagesController,
          addButtonTitle: 'Thêm ảnh',
          addMoreButtonTitle: 'Thêm ảnh',
        ),
      ],
    );
  }
}
