import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tien_duong/app/core/utils/toast_service.dart';

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
        //   "Result", "QR Code: "+scannedQrCode,
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: AppColors.softGreen,
        //   colorText: AppColors.white,
        //   duration: Duration(seconds: 10),
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
    if (images.isNotEmpty || url == null) {
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
}
