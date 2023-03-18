import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/modules/select_route/widgets/select_route_bottom.dart';
import 'package:tien_duong/app/modules/select_route/widgets/select_route_center_right.dart';
import 'package:tien_duong/app/modules/select_route/widgets/select_route_top.dart';

import '../controllers/select_route_controller.dart';
import '../widgets/select_route_map.dart';

class SelectRouteView extends GetView<SelectRouteController> {
  const SelectRouteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: const [
        SelectRouteMap(),
        Bottom(),
        SelectRouteCenterRight(),
        SelectRouteTop(),
      ]),
    );
  }
}
