import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/modules/profile_page/controllers/profile_page_controller.dart';

class AvatarNameProfile extends GetWidget<ProfilePageController> {
  const AvatarNameProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Stack(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      CachedNetworkImageProvider(controller.photoUrl.value),
                ),
              ),
              Positioned(
                  right: -16,
                  bottom: -2,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor:
                              const Color.fromARGB(255, 85, 88, 87),
                          side:
                              const BorderSide(width: 2, color: Colors.white)),
                      onPressed: () async {
                        controller.uploadImage();
                      },
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                      )))
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          flex: 4,
          child: Container(
            height: Get.height * 0.11,
            width: Get.width * 0.74,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                    width: 2, color: Colors.black.withOpacity(0.16))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Họ và tên',
                    style: subtitle2.copyWith(
                        color: Colors.black.withOpacity(0.6)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(flex: 3, child: _inputName()),
                      Flexible(
                          flex: 2,
                          child: SizedBox(
                            height: 32,
                            child: Visibility(
                              child: Obx(
                                () => ElevatedButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsetsGeometry>(
                                            EdgeInsets.zero),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                controller.firstNameField
                                                            .value ==
                                                        controller.initName
                                                    ? Colors.grey
                                                    : Colors.green)),
                                    onPressed: () async {
                                      controller.updateFirstName();
                                    },
                                    child: const Text('Lưu')),
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  TextFormField _inputName() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            )),
      ),
      initialValue: controller.initName,
      onChanged: (String value) {
        controller.firstNameField.value = value;
      },
    );
  }
}
