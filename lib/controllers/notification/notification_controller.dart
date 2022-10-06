import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../tab/tab_screen_controller.dart';

class NotificationController extends GetxController{
  RxList notificationList=[].obs ;


  Future getNotificationList({bool showLoader = true, }) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get.find<TabScreenController>().isLogin.value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getNotificationList+memberId.toString());

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();

      notificationList.clear();
      notificationList.value = jsonDecode(response['body']);
      notificationList.refresh();
      debugPrint("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader)  hideLoadingDialog();
      debugPrint("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR--ELSE-");
    }
  }
}