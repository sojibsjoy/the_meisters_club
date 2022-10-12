import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:xyz/config/date_formator_path_provider/date_formator.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../screens/notification/notification_screen.dart';
import '../../utils/url_launcher/url_launcher.dart';
import '../gradient_text/gradient_text.dart';

Widget appBarTabScreen({
  required Function() onTap1,
  Function()? onTap2,
}) {
  return Container(
    height: 40,
    width: Get.width,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      GestureDetector(
          onTap: onTap1,
          child: SizedBox(width: 40, child: SvgPicture.asset(ImagePath.menu))),
      Expanded(
        // flex: 0,
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "THE MEISTERS CLUB",
              style: regular700.copyWith(color: AppColor.primary, fontSize: 14),
            ),
            Text(
              "welcome to the 1%",
              style: regular400.copyWith(
                  color: AppColor.subFontColor, fontSize: 8),
            )
          ]),
        ),
      ),
      // Get.find<TabScreenController>().isLogin.value ?
      // GestureDetector(onTap:onTap2, child: diamondWithColorWidget()):Container(width: 40,)
    ]),
  );
}

Widget appBarMenuScreen() {
  return Container(
    height: 40,
    width: Get.width,
    // padding: EdgeInsets.symmetric(vertical: 5),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child:
                SizedBox(width: 40, child: SvgPicture.asset(ImagePath.close))),
        Expanded(
          // flex: 0,
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "THE MEISTERS CLUB",
                style:
                    regular700.copyWith(color: AppColor.primary, fontSize: 14),
              ),
              Text(
                "welcome to the 1%",
                style: regular400.copyWith(
                    color: AppColor.subFontColor, fontSize: 8),
              )
            ]),
          ),
        ),
        // Get.find<TabScreenController>().isLogin.value
        //     ? GestureDetector(onTap: () {}, child: diamondWithColorWidget())
        //     : Container(
        //         width: 40,
        //       )
      ],
    ),
  );
}

// Widget diamondWithColorWidget() {
//   return Stack(
//     alignment: Alignment.center,
//     children: [
//       SvgPicture.asset(ImagePath.circle_logo),
//       Positioned(
//         top: 13.5,
//         child: SvgPicture.asset(ImagePath.diamond_shape,
//             color: Color(int.parse(
//                 Get.find<TabScreenController>().diamondColorString.value))),
//       ),
//     ],
//   );
// }

Widget row({required String? text, onTap}) {
  return Row(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          child: const Icon(Icons.menu, color: AppColor.primary, size: 35),
        ),
      ),
      Text(
        text!,
        style: regular900.copyWith(color: AppColor.primary),
      ),
      const Expanded(child: SizedBox()),
    ],
  );
}

circularBorder({double radius = 300}) {
  return BorderRadius.circular(radius);
}

circularBorderParticular({
  double topLeft = 0,
  double topRight = 0,
  double bottomLeft = 0,
  double bottomRight = 0,
}) {
  return BorderRadius.only(
      topLeft: Radius.circular(topLeft),
      bottomRight: Radius.circular(bottomRight),
      bottomLeft: Radius.circular(bottomLeft),
      topRight: Radius.circular(topRight));
}

Widget appBarForNavigateScreen({required String title}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(ImagePath.arrow_back_field),
        ),
      ),
      Text(
        title,
        style: regular700.copyWith(color: AppColor.fontColor, fontSize: 20),
      ),
    ],
  );
}

Widget appBarForMenuScreens({required String title}) {
  return Container(
    height: 60,
    width: Get.width,
    decoration: const BoxDecoration(
      color: AppColor.accent,
      border: Border(bottom: BorderSide(color: AppColor.border)),
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: SizedBox(
            width: Get.width / 8,
            // color: AppColor.red,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(ImagePath.arrowBack),
            )),
      ),
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

Widget profile(
    {required String profileImage,
    double radius = 32,
    bool isBorder = false,
    Color? borderColor /*,bool isListLastImage=false,*/
    }) {
  return SizedBox(
      width: radius,
      height: radius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isBorder)
            CircleAvatar(
              radius: radius,
              backgroundColor: borderColor ?? AppColor.fontColor,
            ),
          CircleAvatar(
            radius: isBorder ? radius - 19 : radius,
            backgroundImage: NetworkImage(
              profileImage,
            ),
            backgroundColor: AppColor.background,
          ),
        ],
      ));
}

Widget loginSignUpBottomRow({
  required String title,
  required String buttonName,
  required Function() onTap,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: regular400.copyWith(
            color: AppColor.whiteColor.withOpacity(0.8), fontSize: 14),
      ),
      // subTitleText(title,fontSize: 14,isSecondLine: true),
      const SizedBox(
        width: 5,
      ),
      GestureDetector(
        onTap: onTap,
        child: Container(
          // color: AppColor.red,
          padding: const EdgeInsets.all(2),
          child: GradientText(
            buttonName,
            gradient: const LinearGradient(
                colors: [AppColor.gradientYellow, AppColor.gradientOrange]),
            style: regular600.copyWith(fontSize: 14),
          ),
        ),
      )
    ],
  );
}

Widget lastProfile(
    {required String profileImage,
    double radius = 32,
    bool isBorder = false,
    Color? borderColor /*,bool isListLastImage=true,*/
    }) {
  return SizedBox(
      width: radius,
      height: radius,
      // decoration: BoxDecoration(color:AppColor.red,borderRadius: circularBorder),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isBorder)
            CircleAvatar(
              radius: radius,
              backgroundColor: borderColor ?? AppColor.fontColor,
            ),
          CircleAvatar(
            radius: isBorder ? radius - 19 : radius,
            backgroundImage: NetworkImage(
              profileImage,
            ),
            backgroundColor: AppColor.background,
          ),
          CircleAvatar(
            radius: isBorder ? radius - 19 : radius,
            backgroundColor: AppColor.background.withOpacity(0.45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "+",
                  textAlign: TextAlign.center,
                  style: regular400.copyWith(fontSize: 15),
                ),
                Text(
                  "999",
                  textAlign: TextAlign.center,
                  style: regular400.copyWith(fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ));
}

Widget titleText(text, {double? fontSize, bool isSecondLine = false}) {
  return Text(
    text ?? "",
    maxLines: isSecondLine ? 2 : 1,
    overflow: TextOverflow.ellipsis,
    style: regular600.copyWith(
        color: AppColor.whiteColor, fontSize: fontSize ?? 15),
  );
}

Widget subTitleText(text, {double? fontSize, bool isSecondLine = false}) {
  return Text(
    text ?? "",
    maxLines: isSecondLine ? 2 : 1,
    overflow: TextOverflow.ellipsis,
    style: regular400.copyWith(
        color: AppColor.whiteColor.withOpacity(0.8), fontSize: fontSize ?? 15),
  );
}

Widget ratingRowWidget() {
  return Row(
    children: [
      SvgPicture.asset(ImagePath.star),
      const SizedBox(
        width: 5,
      ),
      Text(
        "4.5",
        overflow: TextOverflow.ellipsis,
        style: regular400.copyWith(color: AppColor.fontColor, fontSize: 14),
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        "(500 reviews)",
        overflow: TextOverflow.ellipsis,
        style: regular400.copyWith(color: AppColor.subFontColor, fontSize: 14),
      ),
    ],
  );
}

Widget calenderRowWidget({required String dateTime}) {
  return Row(
    children: [
      SvgPicture.asset(ImagePath.calender),
      const SizedBox(
        width: 5,
      ),
      Text(
        CustomDateFormator.dateFormatByMonthName(date: dateTime),
        overflow: TextOverflow.ellipsis,
        style: regular400.copyWith(color: AppColor.subFontColor, fontSize: 14),
      ),
    ],
  );
}

Widget locationRowWidget({required String locationName}) {
  return Row(
    children: [
      SvgPicture.asset(ImagePath.location),
      const SizedBox(
        width: 5,
      ),
      Text(
        locationName,
        overflow: TextOverflow.ellipsis,
        style: regular400.copyWith(color: AppColor.subFontColor, fontSize: 14),
      ),
    ],
  );
}

Widget clockRowWidget({required String time}) {
  return Row(
    children: [
      SvgPicture.asset(ImagePath.clock),
      const SizedBox(
        width: 5,
      ),
      Text(
        /* CustomDateFormator.time_format_by_AM_PM(time: time)*/ time,
        overflow: TextOverflow.ellipsis,
        style: regular400.copyWith(color: AppColor.subFontColor, fontSize: 14),
      ),
    ],
  );
}

linearGradientCommon({bool isStartWithOrange = true}) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.1, 0.1, 1, 0.1],
    colors: isStartWithOrange
        ? [
            AppColor.gradientOrange,
            AppColor.gradientOrange,
            AppColor.gradientYellow,
            AppColor.gradientYellow,
          ]
        : [
            AppColor.gradientYellow,
            AppColor.gradientYellow,
            AppColor.gradientOrange,
            AppColor.gradientOrange,
          ],
  );
}

linearGradientCustomForSVG(
    {required Color startColor,
    required Color endColor,
    required String svgImagePath}) {
  ShaderMask(
    shaderCallback: (bounds) {
      return RadialGradient(
        center: Alignment.topLeft,
        radius: 0.5,
        colors: [
          endColor,
          startColor,
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
    },
    child: SvgPicture.asset(svgImagePath),
  );
}

linearGradientCustom({
  required Color startColor,
  required Color endColor,
}) {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.1, 0.1, 1, 0.1],
    colors: [
      startColor,
      startColor,
      endColor,
      endColor,
    ],
  );
}

class Print {
  Print(Object? object) {
    if (kDebugMode) {
      print("$object");
    }
  }
}

Widget HtmlView({required String text}) {
  return HtmlWidget(
    text,
    customStylesBuilder: (element) {
      if (element.classes.contains('foo')) {
        return {'color': 'red'};
      }

      return null;
    },
    onErrorBuilder: (context, element, error) => Text('$element error: $error'),
    onLoadingBuilder: (context, element, loadingProgress) => const Center(
        child: CircularProgressIndicator(
      color: AppColor.primary,
    )),
    onTapUrl: (url) async {
      debugPrint('tapped $url');
      UrlLauncher.launchLink(url);
      return true;
    },
    renderMode: RenderMode.column,
    textStyle: regular400.copyWith(fontSize: 14, color: AppColor.subFontColor),
  );
}

fixColorCodeFor({required String colorCode}) {
  return "0xFF${colorCode.replaceAll("#", "").trim()}";
}
