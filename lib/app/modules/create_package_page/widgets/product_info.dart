import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:tien_duong/app/modules/create_package_page/widgets/images_view.dart';

class ProductInfo extends GetWidget<CreatePackagePageController> {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.productsFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _length()),
                Gap(12.w),
                Expanded(child: _width()),
              ],
            ),
            Gap(12.h),
            Row(
              children: [
                Expanded(child: _height()),
                Gap(12.w),
                Expanded(child: _weight()),
              ],
            ),
            Gap(16.h),
            Text('Các sản phẩm', style: header),
            Obx(
              () => SizedBox(
                  height: controller.products.length * 150.h,
                  child: _products()),
            ),
            TextButton(
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
                      'Thêm sản phẩm',
                      style: subtitle2.copyWith(color: Colors.blue),
                    )
                  ],
                ),
              ),
              onPressed: () {
                controller.createProductToList();
              },
            ),
            Gap(16.h),
            const ImagesView(),
            Gap(16.h),
          ],
        ),
      ),
    );
  }

  TextFormField _weight() {
    return TextFormField(
        validator: FunctionUtils.validatorNotNull,
        keyboardType: TextInputType.number,
        onChanged: (value) => controller.weight = parseDouble(value),
        initialValue:
            controller.weight == null ? '' : controller.weight.toString(),
        focusNode: controller.focusWeight,
        key: controller.weightKey,
        decoration: InputStyles.createPackage(
                labelText: 'Khối lượng',
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w))
            .copyWith(suffixText: 'kg'));
  }

  TextFormField _height() {
    return TextFormField(
      validator: FunctionUtils.validatorNotNull,
      keyboardType: TextInputType.number,
      onChanged: (value) => controller.height = parseDouble(value),
      initialValue: getInitFiledData(controller.height),
      focusNode: controller.focusHeight,
      key: controller.heightKey,
      decoration: InputStyles.createPackage(
              labelText: 'Chiều cao',
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w))
          .copyWith(suffixText: 'cm'),
    );
  }

  TextFormField _width() {
    return TextFormField(
        validator: FunctionUtils.validatorNotNull,
        keyboardType: TextInputType.number,
        onChanged: (value) => controller.width = parseDouble(value),
        initialValue: getInitFiledData(controller.width),
        focusNode: controller.focusWidth,
        key: controller.widthKey,
        decoration: InputStyles.createPackage(
                labelText: 'Chiều rộng',
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w))
            .copyWith(suffixText: 'cm'));
  }

  TextFormField _length() {
    return TextFormField(
      validator: FunctionUtils.validatorNotNull,
      keyboardType: TextInputType.number,
      initialValue: getInitFiledData(controller.length),
      onChanged: (value) => controller.length = parseDouble(value),
      focusNode: controller.focusLength,
      key: controller.lengthKey,
      decoration: InputStyles.createPackage(
              labelText: 'Chiều dài',
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w))
          .copyWith(suffixText: 'cm'),
    );
  }

  Widget _products() {
    return Obx(
      () => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 34.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputStyles.createPackageZeroPadding(
                                labelText: 'Tên',
                              ),
                              initialValue: controller.products[index].name,
                              validator: FunctionUtils.validatorNotNull,
                              onChanged: (data) {
                                controller.products[index].name = data;
                              },
                            ),
                          ),
                          Gap(8.w),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: InputStyles.createPackageZeroPadding(
                                labelText: 'Đơn giá',
                              ).copyWith(suffixText: 'đ'),
                              initialValue: controller.products[index].price ==
                                      null
                                  ? ''
                                  : controller.products[index].price.toString(),
                              validator: FunctionUtils.validatorNotNull,
                              keyboardType: TextInputType.number,
                              onChanged: (data) {
                                if (data.isNotEmpty) {
                                  controller.products[index].price =
                                      int.parse(data);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      Gap(8.w),
                      TextFormField(
                        decoration: InputStyles.createPackageZeroPadding(
                          labelText: 'Mô tả',
                        ),
                        initialValue: controller.products[index].description,
                        validator: FunctionUtils.validatorNotNull,
                        onChanged: (data) {
                          controller.products[index].description = data;
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: ColorButton(
                      'Xóa',
                      icon: Icons.delete,
                      onPressed: () {
                        controller.deleteProductToList(index);
                      },
                      radius: 6.sp,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                    ))
              ],
            );
          },
          separatorBuilder: (context, index) => Gap(20.h),
          itemCount: controller.products.length),
    );
  }

  String? getInitFiledData(double? value) {
    if (value == null) {
      return null;
    } else {
      return value.toInt().toString();
    }
  }

  double parseDouble(String? value) {
    if (value == null || value.isEmpty) {
      return 0;
    } else {
      return double.parse(value);
    }
  }
}
