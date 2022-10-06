import 'package:get/get.dart';

class TabScreenController extends GetxController{

  RxBool isLogin = false.obs;
  RxString diamondColorString = "".obs;
  //
  RxInt tabIndex=0.obs;
  //
  RxBool isWishListScr = false.obs;
  RxBool isNotificationScr = false.obs;
  RxBool isHomeScr = false.obs;
  RxBool isProfileScr = false.obs;
  RxBool isSettingScr = false.obs;


  setScreen({
    bool isWishList = false,
    bool isNotification = false,
    bool isHome = false,
    bool isProfile = false,
    bool isSetting = false,
  }) {
    //Set Screen
    isWishListScr.value = isWishList ? true : false;
    isNotificationScr.value = isNotification ? true : false;
    isHomeScr.value = isHome ? true : false;
    isProfileScr.value = isProfile ? true : false;
    isSettingScr.value = isSetting ? true : false;

    //Set tabIndex
    tabIndex.value=isWishList?1:isNotification?2:isHome?3:isProfile?4:5;
  }

}