import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/image_path_provider/image_path_provider.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../controllers/support/support_controller.dart';
import '../../../controllers/tab/tab_screen_controller.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import '../../../widgets/custom_button/cutsomButton.dart';
import '../../../widgets/text_field/customTextField.dart';
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
            backgroundThemeWidgetSplashScreen(isOtherScreen: true, isSecondVisible: true),
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
                                      socialMediaIcon(imagePath: ImagePath.facebook,onTap: (){}),
                                      socialMediaIcon(imagePath: ImagePath.instagram,onTap: (){}),
                                      socialMediaIcon(imagePath: ImagePath.twitter,onTap: (){}),
                                      socialMediaIcon(imagePath: ImagePath.youtube,onTap: (){}),
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

Widget socialMediaIcon({required String imagePath,required Function() onTap}) {
  return GestureDetector(
    onTap:onTap,
    child: Container(
      margin: const EdgeInsets.only(right: 18),
      child: SizedBox(
          width: 51,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
          )),
    ),
  );
}
