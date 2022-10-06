import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../controllers/support/support_controller.dart';
import '../../../controllers/tab/tab_screen_controller.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import '../../../widgets/custom_button/cutsomButton.dart';
import '../../../widgets/text_field/customTextField.dart';
import '../../splash/splash_screen.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({Key? key}) : super(key: key);

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
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
            return   Stack(
              alignment: Alignment.topCenter,
              children: [
                backgroundThemeWidgetSplashScreen(isOtherScreen: true, isSecondVisible: true),
                supportController.aboutMap.isNotEmpty?
                Column(
                  children: [
                    appBarForMenuScreens(title: "FAQs"),
                    Expanded(
                      child: SizedBox(
                        height: Get.height-95,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: HtmlView(text: supportController.aboutMap['faqs']),
                              ),
                            ],
                          ) ,
                        ),
                      ),
                    ),
                  ],
                )
                    :Container()
              ],
            );
          }),
        ));
  }
}
