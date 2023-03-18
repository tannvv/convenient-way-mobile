import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/package_complete_controller.dart';

class PackageCompleteView extends GetView<PackageCompleteController> {
  const PackageCompleteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PackageCompleteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PackageCompleteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
