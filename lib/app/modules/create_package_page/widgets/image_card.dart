import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.file, required this.deleteCallback})
      : super(key: key);

  final ImageFile file;
  final Function(ImageFile file) deleteCallback;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          Positioned.fill(
            child: !file.hasPath
                ? Image.memory(
                    file.bytes!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('No Preview'));
                    },
                  )
                : Image.file(
                    File(file.path!),
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              excludeFromSemantics: true,
              onLongPress: () {},
              child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 12.sp,
                  )),
              onTap: () {
                deleteCallback(file);
              },
            ),
          ),
        ],
      ),
    );
  }
}
