import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/screens/menu/FAQs/FAQs_screen.dart';
import 'package:xyz/screens/menu/about_us/about_us_screen.dart';
import 'package:xyz/screens/menu/privacy_policy/privacy_policy_screen.dart';
import 'package:xyz/screens/menu/quick%20links/quick_links_screen.dart';
import 'package:xyz/screens/menu/terms%20and%20condition/terms%20and%20condition%20screen.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../splash/splash_screen.dart';
import 'contact_us/contact_us_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

final profileController = Get.put(ProfileController());

class _MenuScreenState extends State<MenuScreen> {
  final tabController = Get.put(TabScreenController());

  @override
  void initState() {
    profileController.getUserDetails(showLoader: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Obx(() {
      return Scaffold(
        backgroundColor: AppColor.background,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              backgroundThemeWidgetSplashScreen(
                  isOtherScreen: true, isSecondVisible: false),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                appBarMenuScreen(),
                const SizedBox(
                  height: 17,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 17,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: titleText("Dashboard", fontSize: 22),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Welcome to the 1% ' +
                                profileController.profileDetailsMap['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        menuItem(
                            title: "Profile",
                            imagePath: ImagePath.account_unselected,
                            onTap: () {
                              Get.back();
                              tabController.setScreen(isProfile: true);
                            }),
                        menuItem(
                            title: "Notification",
                            imagePath: ImagePath.notifications_unselected,
                            onTap: () {
                              Get.back();
                              tabController.setScreen(isNotification: true);
                            }),
                        menuItem(
                            title: "Chat Rooms",
                            imagePath: ImagePath.chat,
                            onTap: () {
                              Get.back();
                            }),
                        divider(),
                        menuItem(
                            title: "Contact Us",
                            imagePath: ImagePath.contact_us,
                            onTap: () {
                              Get.to(() => const ContactUsScreen());
                            }),
                        menuItem(
                            title: "Terms and Condition",
                            imagePath: ImagePath.terms,
                            onTap: () {
                              Get.to(() => const TermsAndConditionScreen());
                            }),
                        menuItem(
                            title: "Privacy Policy",
                            imagePath: ImagePath.privacy,
                            onTap: () {
                              Get.to(() => const PrivacyPolicyScreen());
                            }),
                        divider(),
                        menuItem(
                            title: "FAQs",
                            imagePath: ImagePath.faq,
                            onTap: () {
                              Get.to(() => const FAQsScreen());
                            }),
                        menuItem(
                            title: "About Us",
                            imagePath: ImagePath.logo_icon,
                            onTap: () {
                              Get.to(() => const AboutUsScreen());
                            }),
                        menuItem(
                            title: "Quick Links",
                            imagePath: ImagePath.link,
                            onTap: () {
                              Get.to(() => const QuickLinksScreen());
                            }),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Get.find<TabScreenController>().isLogin.value
            ? menuProfileRowWidget()
            : Container(),
      );
    }));
  }
}

Widget divider() {
  return Container(
    height: 1,
    width: Get.width / 2,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    // color: AppColor.red,
    decoration: BoxDecoration(
        gradient: linearGradientCustom(
            startColor: AppColor.fontColor, endColor: AppColor.background)),
  );
}

Widget menuItem({
  required String imagePath,
  required String title,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(imagePath, color: AppColor.subFontColor)),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style:
                regular500.copyWith(fontSize: 15, color: AppColor.subFontColor),
          )
        ],
      ),
    ),
  );
}

Widget menuProfileRowWidget() {
  return Obx(() {
    return Container(
      height: 74,
      width: Get.width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColor.accent,
          borderRadius: circularBorder(radius: 10),
          border: Border.all(color: AppColor.border)),
      child: Row(
        children: [
          profileWithBorder(
            profileImage: profileController.profileDetailsMap['image'] ??
                ImagePath.profileNetImageUnknown,
            radius: 44,
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            // color: AppColor.red,
            height: 44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText(profileController.profileDetailsMap['name'],
                    fontSize: 16),
                // Spacer(),
                subTitleText(profileController.profileDetailsMap['email'],
                    fontSize: 14)
              ],
            ),
          ),
          const Spacer(),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     padding: const EdgeInsets.all(10.0),
          //     child: SvgPicture.asset(ImagePath.more_vert),
          //   ),
          // )
        ],
      ),
    );
  });
}

Widget profileWithBorder(
    {required String profileImage,
    double radius = 44,
    Color? borderColor /*,bool isListLastImage=false,*/
    }) {
  ///1.76
  return SizedBox(
      width: radius,
      height: radius,
      // decoration: BoxDecoration(color:AppColor.red,borderRadius: circularBorder),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: borderColor ?? AppColor.fontColor,
          ),
          CircleAvatar(
            radius: radius - (radius / 1.76),
            backgroundImage: NetworkImage(
              profileImage,
            ),
            backgroundColor: AppColor.background,
          ),
        ],
      ));
}
