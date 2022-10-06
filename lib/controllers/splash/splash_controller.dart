import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/screens/tab%20screen/tab%20screen.dart';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../tab/tab_screen_controller.dart';

class SplashScreenController extends GetxController {
  Future<String?> getFrontVideoLink({
    bool showLoader = true,
  }) async {
    if (showLoader) showLoadingDialog();
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.getFrontVideo);

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---${jsonDecode(response['body']).toString().replaceAll("' ", "")}---");
      debugPrint("---SUCCESS---");
      return jsonDecode(response['body']).toString().replaceAll("' ", "").trim();
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR---");
      checkLogin();
    } else {
      if (showLoader) hideLoadingDialog();
      checkLogin();
      debugPrint("---ERROR--ELSE-");
    }
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
}
