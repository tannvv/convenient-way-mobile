import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/utils/function_utils.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/button_color.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';

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
                Expanded(
                    child: TextFormField(
                  validator: FunctionUtils.validatorNotNull,
                  keyboardType: TextInputType.number,
                  initialValue: getInitFiledData(controller.length),
                  decoration: InputStyles.createPackage(
                          labelText: 'Chiều dài',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.w))
                      .copyWith(suffixText: 'cm'),
                )),
                Gap(12.w),
                Expanded(
                    child: TextFormField(
                        validator: FunctionUtils.validatorNotNull,
                        keyboardType: TextInputType.number,
                        initialValue: getInitFiledData(controller.width),
                        decoration: InputStyles.createPackage(
                                labelText: 'Chiều rộng',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.w))
                            .copyWith(suffixText: 'cm'))),
              ],
            ),
            Gap(12.h),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  validator: FunctionUtils.validatorNotNull,
                  keyboardType: TextInputType.number,
                  initialValue: getInitFiledData(controller.height),
                  decoration: InputStyles.createPackage(
                          labelText: 'Chiều cao',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.w))
                      .copyWith(suffixText: 'cm'),
                )),
                Gap(12.w),
                Expanded(
                    child: TextFormField(
                        validator: FunctionUtils.validatorNotNull,
                        keyboardType: TextInputType.number,
                        initialValue: controller.weight == null
                            ? ''
                            : controller.weight.toString(),
                        decoration: InputStyles.createPackage(
                                labelText: 'Khối lượng',
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12.w))
                            .copyWith(suffixText: 'kg'))),
              ],
            ),
            Gap(12.h),
            Text('Các sản phẩm: ',
                style: subtitle2.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeights.medium,
                    color: AppColors.description)),
            Obx(
              () => SizedBox(
                  height: controller.products.length * 150.h,
                  child: _products()),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  controller.createProductToList();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r))),
                ),
                icon:
                    Icon(Entypo.plus, size: 16.sp, color: AppColors.primary800),
                label: Text(
                  'Thêm sản phẩm',
                  style: subtitle2.copyWith(color: AppColors.primary800),
                ))
          ],
        ),
      ),
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
}
