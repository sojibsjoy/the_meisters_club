import 'package:flutter/material.dart';
import '../../controllers/event details/event_detail_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import 'package:get/get.dart';
import 'package:xyz/widgets/recommended_login/recommended_login.dart';
import '../../config/colors_path_provider/colors.dart';
import '../home/home_screen.dart';
import '../notification/notification_screen.dart';
import '../splash/splash_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

final eventDetailsController = Get.put(EventDetailsController());

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    getWishList();
    super.initState();
  }

  getWishList() {
    if (Get.find<TabScreenController>().isLogin.value) {
      eventDetailsController.getWishList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Column(children: [
        wishlistAppBar(),
        Obx(() {
          return Stack(
            alignment: Get.find<TabScreenController>().isLogin.value
                ? Alignment.topCenter
                : Alignment.center,
            children: [
              backgroundThemeWidgetSplashScreen(
                  isOtherScreen: true, isSecondVisible: false),
              Get.find<TabScreenController>().isLogin.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: Get.height - 177.7,
                        child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            itemCount:
                                eventDetailsController.eventWishList.length,
                            itemBuilder: ((context, index) {
                              return upComingEventsWidget(
                                eventId: eventDetailsController
                                    .eventWishList[index]['eventId'],
                                image: eventDetailsController
                                        .eventWishList[index]['homeBanner'] ??
                                    '',
                                title: eventDetailsController
                                    .eventWishList[index]['eventName'],
                                locationName: eventDetailsController
                                    .eventWishList[index]['location'],
                                date: eventDetailsController
                                    .eventWishList[index]['eventDate'],
                                isLiked: eventDetailsController
                                    .eventWishList[index]['isWished'],
                                onTap: () async {
                                  eventDetailsController.eventWishList[index]
                                          ['isWished'] =
                                      !eventDetailsController
                                          .eventWishList[index]['isWished'];
                                  eventDetailsController.eventWishList
                                      .refresh();
                                  await eventDetailsController
                                      .addToWishListEvents(
                                          eventId: eventDetailsController
                                              .eventWishList[index]['eventId']);
                                  eventDetailsController.getWishList(
                                      showLoader: false);
                                },
                                isFullWidth: true,
                                isEligble: eventDetailsController
                                        .eventWishList[index]['isEligble'] ??
                                    false,
                              );
                            })),
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: LoginRecommendedWidget(
                        afterCompletion: () {
                          eventDetailsController.getWishList();
                        },
                      ))
            ],
          );
        })
      ]),
    ));
  }
}

Widget wishlistAppBar() {
  return Container(
    height: 60,
    width: Get.width,
    decoration: const BoxDecoration(
      color: AppColor.accent,
      border: Border(bottom: BorderSide(color: AppColor.border)),
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      // GestureDetector(
      //   onTap: () {
      //     Get.back();
      //   },
      //   child: Container(
      //       width: Get.width / 8,
      //       // color: AppColor.red,
      //       child: Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: SvgPicture.asset(ImagePath.arrowBack),
      //       )),
      // ),
      const SizedBox(
        width: 16,
      ),
      titleAppBar("WishList"),
      const Spacer(),
      // Align(
      //   alignment: Alignment.center,
      //   child: Container(
      //     padding: const EdgeInsets.all(10.0),
      //     margin: const EdgeInsets.only(right: 10),
      //     child: SvgPicture.asset(ImagePath.more_vert),
      //   ),
      // )
    ]),
  );
}
