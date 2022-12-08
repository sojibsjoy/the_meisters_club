import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../controllers/event details/event_detail_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class AllEventScreen extends StatefulWidget {
  const AllEventScreen({Key? key}) : super(key: key);

  @override
  _AllEventScreenState createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen> {
  final eventDetailsController = Get.put(EventDetailsController());

  @override
  void initState() {
    initApiCall();
    super.initState();
  }

  initApiCall() {
    eventDetailsController.getUpcomingEvents(
      isHome: false,
    );
  }

  Future onRefresh() async {
    initApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: appBarForNavigateScreen(title: "THE 1% EXPERIENCE"),
          ),
          const SizedBox(height: 4),
          Obx(() {
            return Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                color: AppColor.pullToRefreshLoader,
                backgroundColor: AppColor.pullToRefreshBG,
                child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: eventDetailsController.eventListAll.length,
                    itemBuilder: ((context, index) {
                      return upComingEventsWidget(
                        eventId: eventDetailsController.eventListAll[index]
                            ['eventId'],
                        image: eventDetailsController.eventListAll[index]
                            ['homeBanner'],
                        title: eventDetailsController.eventListAll[index]
                            ['eventName'],
                        locationName: eventDetailsController.eventListAll[index]
                            ['location'],
                        date: eventDetailsController.eventListAll[index]
                            ['eventDate'],
                        isLiked: eventDetailsController.eventListAll[index]
                            ['isWished'],
                        onTap: () {
                          if (Get.find<TabScreenController>().isLogin.value) {
                            eventDetailsController.eventListAll[index]
                                    ['isWished'] =
                                !eventDetailsController.eventListAll[index]
                                    ['isWished'];
                            eventDetailsController.eventListAll.refresh();
                            eventDetailsController.addToWishListEvents(
                                eventId: eventDetailsController
                                    .eventListAll[index]['eventId']);
                          } else {
                            Get.to(() => const LoginScreen());
                          }
                        },
                        isFullWidth: true,
                        isEligble: eventDetailsController.eventListAll[index]
                                ['isEligble'] ??
                            false,
                      );
                    })),
              ),
            );
          }),
        ],
      ),
    ));
  }
}
