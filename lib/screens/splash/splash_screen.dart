import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../controllers/splash/splash_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../tab screen/tab screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final tabScreenController = Get.put(TabScreenController());
  final splashScreenController = Get.put(SplashScreenController());
  VideoPlayerController? _controller;

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData()async{
   // String videoLink= await splashScreenController.getFrontVideoLink()??"";
   // print("############## $videoLink -----------");
   _controller =
   VideoPlayerController.asset("assets/video/frontVideo.mp4")
     ..initialize().then((_) {
       setState(() {});
       _controller?.play();
     });


    Timer(const Duration(seconds: 8),() {
      checkLogin();
    },);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Future checkLogin() async {
    bool isLog =
        await getDataFromLocalStorage(dataType: StorageKey.boolType, storageKey: StorageKey.isLogin) ?? false;
    String colorDiamond =
        await getDataFromLocalStorage(dataType: StorageKey.stringType, storageKey: StorageKey.packageColor) ??
            "";
    Get.find<TabScreenController>().isLogin.value = isLog;
    Get.find<TabScreenController>().diamondColorString.value = colorDiamond;
    Get.offAll(() => const TabScreen());
  }

  @override
  Widget build(BuildContext context) {
    // print("--${_controller!.value}-");
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          backgroundThemeWidgetSplashScreen(),
          if (_controller != null)
          _controller!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
              : Container(),
        ],
      ),
    );
  }
}

Widget backgroundThemeWidgetSplashScreen({
  bool isFirstVisible = true,
  bool isSecondVisible = true,
  bool isOtherScreen = false,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Align(
        alignment: Alignment.topRight,
        child: isFirstVisible
            ? Container(
                height: isOtherScreen ? (Get.height - 60) / 1.44 : Get.height / 1.44,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(ImagePath.sideLayer, fit: BoxFit.cover),
                    if (isOtherScreen)
                      Container(
                        color: AppColor.background.withOpacity(0.5),
                      ),
                  ],
                ))
            : Container(),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child: isSecondVisible
            ? Container(
                height: isOtherScreen ? (Get.height - 60) / 4.87 : Get.height / 4.87,
                child: Image.asset(ImagePath.bottomLayer, fit: BoxFit.cover))
            : Container(),
      ),
    ],
  );
}
