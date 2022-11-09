import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../controllers/news_and_update/news_and_update_controller.dart';
import '../../controllers/offers/offers_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../home/home_screen.dart';
import 'package:html/parser.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({Key? key}) : super(key: key);

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

final offersController = Get.put(OffersController());

class _OfferListScreenState extends State<OfferListScreen> {
  @override
  void initState() {
    initApiCall();
    super.initState();
  }

  initApiCall() {
    offersController.getUpcomingOffers(isHome: false);
  }

  Future onRefresh() async {
    initApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: appBarForNavigateScreen(title: "PARTNERS DISCOUNT"),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: offersController.offerListAll.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: onRefresh,
                      color: AppColor.pullToRefreshLoader,
                      backgroundColor: AppColor.pullToRefreshBG,
                      child: ListView(
                        children: [
                          GridView.count(
                              scrollDirection: Axis.vertical,
                              //default
                              reverse: false,
                              //default
                              controller: ScrollController(),
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              addAutomaticKeepAlives: true,
                              //default
                              addRepaintBoundaries: true,
                              //default
                              addSemanticIndexes: true,
                              //default
                              semanticChildCount: 0,
                              cacheExtent: 0.0,
                              mainAxisSpacing: 8,
                              // dragStartBehavior: DragStartBehavior.start,
                              clipBehavior: Clip.hardEdge,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.manual,
                              crossAxisCount: 2,
                              children: List.generate(
                                  offersController.offerListAll.length,
                                  (index) {
                                return offerWidget(
                                  offerId: offersController.offerListAll[index]
                                      ['offerId'],
                                  title: offersController.offerListAll[index]
                                      ['companyName'],
                                  offerRate: offersController
                                      .offerListAll[index]['discount']
                                      .toString(),
                                  image: offersController.offerListAll[index]
                                      ['companyBanner'],
                                  isEligble: offersController
                                          .offerListAll[index]['isEligble'] ??
                                      false,
                                );
                              }) // List of Widgets
                              ),
                        ],
                      ),
                    )
                  : Container(),
            )
          ],
        );
      }),
    ));
  }
}
