import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:xyz/config/API/api_endpoints.dart';
import 'package:xyz/config/colors_path_provider/colors.dart';
import 'package:xyz/config/image_path_provider/image_path_provider.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';
import 'package:xyz/screens/connect_NFT/connect_NFT_screen.dart';
import 'package:xyz/screens/profile/profile_screen.dart';
import 'package:xyz/utils/http_handler/network_http.dart';
import 'package:xyz/utils/storage_preference/shared_preferences_service.dart';

import '../../controllers/tab/tab_screen_controller.dart';
import '../../utils/toast/toast.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../../widgets/recommended_login/recommended_login.dart';
import '../notification/notification_screen.dart';
import '../splash/splash_screen.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  initData() {
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint("FBtoken is---------------------------- $value------------");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.background,
            body: Obx(() {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  backgroundThemeWidgetSplashScreen(isOtherScreen: true, isSecondVisible: true),
                  Column(
                    children: [
                      appBarForSettingScreens(title: "Settings"),
                      Expanded(
                        child: Get
                            .find<TabScreenController>()
                            .isLogin
                            .value
                            ? SizedBox(
                          height: Get.height - 95,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  item(
                                    title: "Edit Profile",
                                    onTap: () {
                                      Get.to(() =>
                                      const ProfileScreen(
                                        isEditProfile: true,
                                      ));
                                    },
                                  ),
                                  item(
                                      title: "Logout",
                                      onTap: () {
                                        clearLocalStorage();
                                        Get
                                            .find<TabScreenController>()
                                            .isLogin
                                            .value = false;
                                        Toast.successToast(message: "Logout Success");
                                      },
                                      suffixIcon: Icons.logout_rounded),


                                ],
                              ),
                            ),
                          ),
                        )
                            : Center(
                            child: LoginRecommendedWidget(
                              afterCompletion: () {},
                            )),
                      ),
                    ],
                  )
                ],
              );
            })));
  }
}

Widget item({required String title, required Function() onTap, IconData? suffixIcon}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: circularBorder(radius: 10),
          color: AppColor.accent,
          border: Border.all(color: AppColor.textFieldBorder.withOpacity(0.4))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(title, style: regular600.copyWith(color: AppColor.primary)),
          const Spacer(),
          Icon(
            suffixIcon ?? Icons.arrow_forward_ios_rounded,
            color: AppColor.primary,
          )
        ],
      ),
    ),
  );
}

Widget logout() {
  return GestureDetector(
    onTap: () {
      clearLocalStorage();
      Get
          .find<TabScreenController>()
          .isLogin
          .value = false;
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "LOG OUT",
        style: regular700.copyWith(color: AppColor.primary),
      ),
    ),
  );
}

Widget appBarForSettingScreens({required String title}) {
  return Container(
    height: 60,
    width: Get.width,
    decoration: const BoxDecoration(
      color: AppColor.accent,
      border: Border(bottom: BorderSide(color: AppColor.border)),
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(
        width: 16,
      ),
      titleAppBar(title),
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


class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const RadialGradient(
          center: Alignment.topLeft,
          radius: 0.5,
          colors: [ AppColor.primary,AppColor.yellowColor,],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}