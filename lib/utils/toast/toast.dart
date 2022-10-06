import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:xyz/config/colors_path_provider/colors.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';

double toastIconSize = 30;
double toastHeight = 85;
double toastBorderRadius = 10;
double toastMessageFontSize = 13;
double toastTitleFontSize = 16;

class Toast {
  static successToast({ required String message, bool? isNeedFocus = true}) {
    /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.success(
      title:  titleToast("Success"),
      description: subTitleToast(message),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(Get.context!).size.width - 15,
      borderRadius: toastBorderRadius,

    ).show(Get.context!);
  }

  static warningToast({ double? height,@required String? message, String? title, bool? isNeedFocus = true}) {
    /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.warning(
      title: titleToast(title??'Warning'),
      description: subTitleToast(message!),
      iconSize: toastIconSize,
      height: height ?? toastHeight,
      width: MediaQuery.of(Get.context!).size.width - 15,
      borderRadius: toastBorderRadius,
      
    ).show(Get.context!);
  }

  static errorToast({ @required String? message, bool? isNeedFocus = true}) {
    /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.error(
      title: titleToast('Error'),
      description: subTitleToast(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(Get.context!).size.width - 15,
      borderRadius: toastBorderRadius,
      dismissable: true,
    ).show(Get.context!);
  }

  static infoToast(
      {
        @required String? message,
        @required String? title,
        bool? isNeedFocus = false}) {
    /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.info(
      title: titleToast(title!),
      description: subTitleToast(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(Get.context!).size.width - 15,
      borderRadius: toastBorderRadius,

    ).show(Get.context!);
  }

  static deleteToast({ @required String? message, bool? isNeedFocus = true}) {
    /*bool? isLoggedIn = await getDataFromLocalStorage(dataType: StorageKey.boolType, prefKey: StorageKey.isLogin);*/
    MotionToast.delete(
      title: titleToast("Deleted"),
      description: subTitleToast(message!),
      iconSize: toastIconSize,
      height: toastHeight,
      width: MediaQuery.of(Get.context!).size.width - 15,
      borderRadius: toastBorderRadius,
    ).show(Get.context!);
  }
}

titleToast(String title){
  return  Text(title,style: regular500.copyWith(color: AppColor.background,fontSize: 16),);
}

subTitleToast(String subTitle){
  return  Text(subTitle,style: regular400.copyWith(color: AppColor.background.withOpacity(0.8)),);
}
