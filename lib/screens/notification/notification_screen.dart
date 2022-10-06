import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/widgets/recommended_login/recommended_login.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/notification/notification_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../utils/login_checker/login_checker.dart';
import '../chat_list/messages/messages_screen.dart';
import '../splash/splash_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

final notificationController = Get.put(NotificationController());

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    if(Get
        .find<TabScreenController>()
        .isLogin
        .value) {
      notificationController.getNotificationList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.background,
          body: Stack(
            children: [
              backgroundThemeWidgetSplashScreen(isOtherScreen: true, isSecondVisible: false),
              Column(
                children: [
                  appBarNotificationScrn(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          children: [

                        Obx(() {
                          return Get
                              .find<TabScreenController>()
                              .isLogin
                              .value
                              ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: notificationController.notificationList.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: ((context, index1) {
                                return ListView.builder(
                                  itemCount:
                                  notificationController.notificationList[index1]['messages'].length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index2) {
                                    return notificationWidget(isPremium: true,
                                        title: notificationController
                                            .notificationList[index1]['messages'][index2]['message'],
                                        time: notificationController.notificationList[index1]['messages'
                                        ][index2]['time']);
                                  }),
                                );
                              }),
                            ),
                          )
                              : Container(
                            // color: AppColor.red,
                                height: Get.height-165,
                                child: Align(
                                alignment: Alignment.center,
                                child: LoginRecommendedWidget(
                                  afterCompletion: () {
                                    notificationController.getNotificationList();
                                  },
                                )),
                              );
                        })
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget appBarNotificationScrn() {
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
      titleAppBar("Notifications"),
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

Widget notificationWidget({required bool isPremium, required String title, required String time,}) {
  return Container(
    width: Get.width,
    margin: const EdgeInsets.only(bottom: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 33,
              width: 33,
              // color: AppColor.red,
              child: SvgPicture.asset(
                ImagePath.circle_border,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: isPremium
                  ? Image.asset(ImagePath.logo_only)
                  : Padding(
                padding: const EdgeInsets.all(1.0),
                child: SvgPicture.asset(ImagePath.notification_list_icon),
              ),
            ),
          ],
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 5 /*,right: 100*/),
            // width: Get.width - 40,
            padding: chatPadding,
            decoration: BoxDecoration(
                borderRadius: borderRadius(isSender: false),
                // gradient: linearGradientCommon(isStartWithOrange: false),
                color: AppColor.border),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment: ,
              children: [
                Text(
                  title,
                  maxLines: 5,
                  // softWrap: true,
                  style: regular400.copyWith(fontSize: 14),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: regular400.copyWith(fontSize: 12, color: AppColor.subFontColor),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 4.57),
                      //   child: SvgPicture.asset(
                      //     ImagePath.check,
                      //     color: AppColor.subFontColor,
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget titleAppBar(text,) {
  return Text(
    text ?? "",
    overflow: TextOverflow.ellipsis,
    style: regular700.copyWith(color: AppColor.whiteColor, fontSize: 20),
  );
}
