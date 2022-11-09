import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xyz/config/image_path_provider/image_path_provider.dart';
import 'package:xyz/utils/toast/toast.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../controllers/support/support_controller.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import '../../splash/splash_screen.dart';

class QuickLinksScreen extends StatefulWidget {
  const QuickLinksScreen({Key? key}) : super(key: key);

  @override
  State<QuickLinksScreen> createState() => _QuickLinksScreenState();
}

class _QuickLinksScreenState extends State<QuickLinksScreen> {
  final supportController = Get.put(SupportController());

  @override
  void initState() {
    supportController.getAboutApp();
    super.initState();
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
            backgroundThemeWidgetSplashScreen(
                isOtherScreen: true, isSecondVisible: true),
            supportController.aboutMap.isNotEmpty
                ? Column(
                    children: [
                      appBarForMenuScreens(title: "Quick Links"),
                      Expanded(
                        child: SizedBox(
                          height: Get.height - 95,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  titleText("Social Media", fontSize: 22),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Row(
                                    children: [
                                      socialMediaIcon(
                                        imagePath: ImagePath.tiktok,
                                        link:
                                            "https://www.tiktok.com/@themeistersclub",
                                      ),
                                      socialMediaIcon(
                                        imagePath: ImagePath.instagram,
                                        link:
                                            "https://www.instagram.com/themeistersclub/",
                                      ),
                                      socialMediaIcon(
                                        imagePath: ImagePath.twitter,
                                        link:
                                            "https://twitter.com/themeistersclub",
                                      ),
                                      socialMediaIcon(
                                        imagePath: ImagePath.youtube,
                                        link:
                                            "https://www.youtube.com/channel/UCpME43uj2cak3yUS0sLckYA",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        );
      }),
    ));
  }
}

Widget socialMediaIcon({
  required String imagePath,
  required String link,
}) {
  return GestureDetector(
    onTap: () async {
      if (await canLaunchUrl(Uri.parse(link))) {
        await launchUrl(Uri.parse(link));
      } else {
        Toast.successToast(
          message: "Failed to Open!",
        );
      }
    },
    child: Container(
      width: 51,
      margin: const EdgeInsets.only(right: 18),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
          child: Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      )),
    ),
  );
}
