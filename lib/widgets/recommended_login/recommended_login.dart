import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/colors_path_provider/colors.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';
import 'package:xyz/screens/login/login_screen.dart';
import 'package:xyz/widgets/gradient_text/gradient_text.dart';

import '../../controllers/tab/tab_screen_controller.dart';

class LoginRecommendedWidget extends StatefulWidget {
  // final bool isProfileScr;
  // final bool isNotificationScr;
  // final bool isWishListScr;
  final Function()? afterCompletion;

  const LoginRecommendedWidget({ /*this.isWishListScr = false,
      this.isNotificationScr = false,
      this.isProfileScr = false,*/
    required this.afterCompletion});

  @override
  State<LoginRecommendedWidget> createState() => _LoginRecommendedWidgetState();
}

class _LoginRecommendedWidgetState extends State<LoginRecommendedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.red,
      height: 125,
      child: Obx(() {
        return Column(children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColor.primary.withOpacity(0.3),
            size: 50,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Please Login to continue",
            style: regular400.copyWith(fontSize: 10, color: AppColor.subFontColor.withOpacity(0.5)),
          ),
          const SizedBox(
            height: 8,
          ),
          if (!Get
              .find<TabScreenController>()
              .isLogin
              .value)
          GestureDetector(
            onTap: () {
              Get.to(const LoginScreen())?.whenComplete(() {
                print("------------whencomplete----- 1");
                if (Get
                    .find<TabScreenController>()
                    .isLogin
                    .value) {
                  print("------------whencomplete----- 2");

                  if (widget.afterCompletion != null) {
                    print("------------whencomplete----- 3");
                    widget.afterCompletion!.call();
                  }else{
                    print("------------whencomplete----- 4");
                  }
                }
              });
            },
            child: Container(
              // color: AppColor.red,
              padding: const EdgeInsets.all(8),
              child: GradientText(
                "Login",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: regular700.copyWith(color: AppColor.primary, fontSize: 12),
                gradient: const LinearGradient(colors: [AppColor.gradientYellow, AppColor.gradientOrange]),
              ),
            ),
          )
        ]);
      }),
    );
  }
}
