import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/core/widgets/custom_body_scaffold.dart';
import 'package:tien_duong/app/core/widgets/header_scaffold.dart';
import 'package:tien_duong/app/modules/rating/tabs/creator_tab/creator_tab_view.dart';
import 'package:tien_duong/app/modules/rating/tabs/receiver_tab/receiver_tab_view.dart';
import 'package:tien_duong/app/modules/rating/widgets/rating_info_user.dart';

import '../controllers/rating_controller.dart';
import '../widgets/tab_silver_delegate.dart';

class RatingView extends GetView<RatingController> {
  const RatingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyScaffold(
        header: _header(),
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
                headerSliverBuilder: ((context, innerBoxIsScrolled) {
                  return <Widget>[
                    const SliverToBoxAdapter(
                      child: RatingUserInfo(),
                    ),
                    SliverPersistentHeader(
                      delegate: TabSliverDelegate(TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[400],
                        indicatorColor: Colors.black,
                        tabs: controller.tabsTitle
                            .map((e) => Tab(
                                  child: Text(
                                    e,
                                    style: subtitle2,
                                  ),
                                ))
                            .toList(),
                      )),
                      pinned: true,
                    ),
                  ];
                }),
                body: const TabBarView(children: [
                  CreatorTabView(),
                  ReceiverTabView(),
                ]))),
      ),
    );
  }

  Widget _header() {
    return const HeaderScaffold(
      title: 'Đánh giá',
      isBack: true,
    );
  }
}
