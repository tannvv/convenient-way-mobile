import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/core/base/base_controller.dart';
import 'package:tien_duong/app/core/controllers/auth_controller.dart';
import 'package:tien_duong/app/data/models/account_rating_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/modules/rating/tabs/creator_tab/creator_tab_view.dart';
import 'package:tien_duong/app/modules/rating/tabs/receiver_tab/receiver_tab_view.dart';

import '../../../data/models/info_user_model.dart';

class RatingController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final AuthController _authController = Get.find<AuthController>();
  final Rx<AccountRating?> accountRating = Rx<AccountRating?>(null);

  final AccountRep _accountRep = Get.find(tag: (AccountRep).toString());

  InfoUser get userInfo => _authController.account!.infoUser!;
  final RxList<String> tabsTitle = [
    'Đã đánh giá',
    'Được đánh giá',
  ].obs;

  final List<Widget> _screens = const [
    CreatorTabView(),
    ReceiverTabView(),
  ];

  List<Widget> get screens => _screens;

  final indexScreen = 0.obs;
  Widget get currentScreen => _screens[indexScreen.value];

  void changeTab(int index) {
    indexScreen.value = index;
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  Future<void> fetchRating() async {
    var future = _accountRep.getRating(_authController.account!.id!);
    await callDataService<AccountRating>(
      future,
      onSuccess: (data) {
        accountRating.value = data;
      },
    );
  }
}
