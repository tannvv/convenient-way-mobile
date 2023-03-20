import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';
import 'package:tien_duong/app/data/models/package_model.dart';

class PickUpFileController extends GetxController {
  late PermissionStatus permission;
  final ImagePicker _picker = ImagePicker();
  ImagePicker get picker => _picker;
  final _storage = FirebaseStorage.instance;

  Future<bool> requestPermission() async {
    PermissionStatus permission = await Permission.photos.status;
    if (permission.isDenied) {
      permission = await Permission.photos.request();
      if (permission.isGranted) {
        return true;
      }
    }
    return false;
  }

  Package package = Package();

  Future<String?> scanQR() async {
    try {
      final scannedQrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (scannedQrCode != "-1") {
        // Get.snackbar(
        //   "Thông Tin",
        //   "\nMã nhận hàng: "+scannedQrCode,
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: AppColors.softGreen,
        //   colorText: AppColors.white,
        //   duration: Duration(seconds: 30),
        // );
        return scannedQrCode as String;
      }
    } on PlatformException {}
  }

  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<List<XFile>> pickMultiImage() async {
    return await _picker.pickMultiImage();
  }

  Future<String?> uploadImageToFirebase(XFile? image, String? url) async {
    if (image == null || url == null) {
      ToastService.showError('Lỗi Không thể tải ảnh lên');
      return null;
    }
    try {
      File fileImage = File(image.path);
      var snapshot = await _storage.ref(url).putFile(fileImage);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ToastService.showError('Lỗi Không thể tải ảnh lên');
      return null;
    }
  }

  Future<List<String>> uploadImagesToFirebase(
      List<XFile> images, String? url) async {
    if (images.isEmpty || url == null) {
      ToastService.showError('Chưa lấy được ảnh');
      return [];
    }
    try {
      List<String> imagesUrl = [];
      for (var image in images) {
        String fileName = image.path.substring(image.path.lastIndexOf('/'));
        File fileImage = File(image.path);
        var snapshot = await _storage.ref('$url/$fileName').putFile(fileImage);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imagesUrl.add(downloadUrl);
      }
      return imagesUrl;
    } catch (e) {
      ToastService.showError('Lỗi Không thể tải ảnh lên');
      return [];
    }
  }

  Future<List<String>> uploadImagesToFirebase2(
      {required Iterable<ImageFile> images,
      String? url,
      Function()? onStart,
      Function()? onComplete}) async {
    if (images.isEmpty || url == null) {
      ToastService.showError('Chưa lấy được ảnh');
      return [];
    }
    try {
      onStart != null ? onStart() : null;
      List<String> imagesUrl = [];
      for (var image in images) {
        if (image.path != null) {
          String fileName = image.path!.substring(image.path!.lastIndexOf('/'));
          File fileImage = File(image.path!);
          var snapshot =
              await _storage.ref('$url/$fileName').putFile(fileImage);
          String downloadUrl = await snapshot.ref.getDownloadURL();
          imagesUrl.add(downloadUrl);
        }
      }
      return imagesUrl;
    } catch (e) {
      ToastService.showError('Lỗi Không thể tải ảnh lên');
      return [];
    } finally {
      onComplete != null ? onComplete() : null;
    }
  }
}
