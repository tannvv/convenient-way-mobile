import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';

class ProductInfo extends GetWidget<CreatePackagePageController> {
  const ProductInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Thể tích',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  suffixText: 'm3',
                ),
              )),
              Gap(12.w),
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'Khối lượng',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                    suffixText: 'kg'),
              )),
            ],
          ),
          Gap(12.h),
          Text('Chi tiết: ', style: subtitle2.copyWith(fontSize: 16.sp)),
          SizedBox(height: 250.h, child: _products()),
          ElevatedButton.icon(
              onPressed: () {
                controller.createProductToList();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r))),
              ),
              icon: Icon(Entypo.plus, size: 16.sp, color: AppColors.primary800),
              label: Text(
                'Thêm sản phẩm',
                style: subtitle2.copyWith(color: AppColors.primary800),
              ))
        ],
      ),
    );
  }

  Widget _products() {
    return Obx(
      () => ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              height: 120.h,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              decoration: InputStyles.map(
                                labelText: 'Tên',
                              ),
                              onChanged: (data) {
                                controller.products[index].name = data;
                              },
                            ),
                          ),
                          Gap(8.w),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: InputStyles.map(
                                labelText: 'Đơn giá',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (data) {
                                controller.products[index].price =
                                    int.parse(data);
                              },
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        decoration: InputStyles.map(
                          labelText: 'Mô tả',
                        ),
                        onChanged: (data) {
                          controller.products[index].description = data;
                        },
                      ),
                    ],
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                          child: const Icon(Entypo.cancel_circled),
                          onTap: () {
                            controller.deleteProductToList(index);
                          }))
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Gap(20.h),
          itemCount: controller.products.length),
    );
  }
}
