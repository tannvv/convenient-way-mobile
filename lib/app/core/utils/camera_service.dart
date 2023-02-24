import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraService {
  Future<String?> scanQR() async {
    try{
      final scannedQrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if(scannedQrCode!="-1"){
        Get.snackbar(
          "Result", "QR Code: "+scannedQrCode,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 10),
        );
        return scannedQrCode as String;
      }
    } on PlatformException {}
  }

  Future<File?> getFromCamera() async {
    XFile? pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    )) as XFile?;
  return File(pickedFile!.path);
  }
}
