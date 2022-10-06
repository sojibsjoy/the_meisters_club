import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../utils/notification/notification_provider.dart';
import '../../widgets/gradient_text/gradient_text.dart';
import '../home/home_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';
import '../setting/setting_screen.dart';
import '../wish_list/wish_list_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final tabController = Get.put(TabScreenController());
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController.setScreen(isHome: true);
    profileController.getUserDetails(showLoader: false);

    // NotificationProvider.checkAndRequestNotificationPermission();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() {
          return Scaffold(
            backgroundColor: AppColor.background,
            body: tabController.isHomeScr.value
                ? const HomeScreen()
                : tabController.isNotificationScr.value
                ? const NotificationScreen()
                : tabController.isProfileScr.value
                ? const ProfileScreen()
                : tabController.isSettingScr.value
                ? const SettingsScreen()
                : tabController.isWishListScr.value
                ? const WishListScreen()
                : Container(),
            bottomNavigationBar: SizedBox(
              height: 70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: Get.width,
                    child: Image.asset(ImagePath.nav_bar_bg_Image_png, fit: BoxFit.cover),
                  ),
                  Container(
                    width: Get.width,
                    color: const Color(0xff13171D).withOpacity(0.9),
                  ),
                  Container(
                    child: Row(mainAxisSize: MainAxisSize.max, children: [
                      bottomItem(
                        title: "Wishlist",
                        index: 1,
                        selectedImage: ImagePath.favorite_selected,
                        unSelectedImage: ImagePath.favorite_unselected,
                        onTap: () => tabController.setScreen(isWishList: true),
                      ),
                      bottomItem(
                        title: "Notification",
                        index: 2,
                        selectedImage: ImagePath.notifications_selected,
                        unSelectedImage: ImagePath.notifications_unselected,
                        onTap: () => tabController.setScreen(isNotification: true),
                      ),
                      bottomItem(
                        title: "Home",
                        index: 3,
                        selectedImage: ImagePath.home_selected,
                        unSelectedImage: ImagePath.home_unselected,
                        onTap: () => tabController.setScreen(isHome: true),
                      ),
                      bottomItem(
                        title: "Profile",
                        index: 4,
                        selectedImage: ImagePath.account_selected,
                        unSelectedImage: ImagePath.account_unselected,
                        onTap: () => tabController.setScreen(isProfile: true),
                      ),
                      bottomItem(
                        title: "Settings",
                        index: 5,
                        selectedImage: ImagePath.settings_selected,
                        unSelectedImage: ImagePath.settings_unselected,
                        onTap: () => tabController.setScreen(isSetting: true),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget bottomItem({
    required String title,
    required int index,
    required String selectedImage,
    required String unSelectedImage,
    required Function() onTap,
  }) {
    return Expanded(
      child: Obx(() {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            // height: 42,
            color: index.isEven ? AppColor.transparent : AppColor.transparent,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                tabController.tabIndex.value == index
                    ? Image.asset(
                  selectedImage,
                  width: 20,
                  height: 20,
                )
                    : SvgPicture.asset(
                  unSelectedImage,
                  width: 20,
                  height: 20,
                ),
                Spacer(),
                // if (tabController.tabIndex.value == index)
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: GradientText(
                    tabController.tabIndex.value == index ? title : "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: regular700.copyWith(color: AppColor.primary, fontSize: 12),
                    gradient:
                    const LinearGradient(colors: [AppColor.gradientYellow, AppColor.gradientOrange]),
                  ),
                ),
                /*if (tabController.tabIndex.value != index)*/
              ],
            ),
          ),
        );
      }),
    );
  }
}
