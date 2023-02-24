import 'package:tien_duong/app/core/widgets/hyper_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cancel_package_controller.dart';

class CancelPackageView extends GetView<CancelPackageController> {
  const CancelPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gửi yêu cầu hủy đơn hàng!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: controller.formKey,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.textCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Nhập lí do',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Vui lòng nhập lí do';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.cancelPackage();
                    },
                    child: Obx(() => HyperButton.childWhite(
                        status: controller.isLoading,
                        child: const Text('Yêu cầu hủy đơn'),
                        loadingText: 'Đang tải')))
              ],
            ),
          ),
        ),
      )
    );
  }
}
