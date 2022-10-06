import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/API/api_endpoints.dart';
import 'package:xyz/config/storage_key_path_provider/storage_key_path_provider.dart';
import 'package:xyz/utils/http_handler/network_http.dart';
import 'package:xyz/utils/loading_dialog/loading_dialog.dart';
import 'package:xyz/utils/storage_preference/shared_preferences_service.dart';

import '../../utils/login_checker/login_checker.dart';
import '../../utils/toast/toast.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../tab/tab_screen_controller.dart';

class EventDetailsController extends GetxController {
  final scrollController = ScrollController();
  RxList<dynamic> eventListHome = [].obs;
  RxList<dynamic> eventListAll = [].obs;
  RxList<dynamic> eventWishList = [].obs;
  RxList<dynamic> eventJoinedList = [].obs;

  //
  RxMap eventDetails = {}.obs;

  Future getUpcomingEvents({bool showLoader = true, required bool isHome}) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getEvents(memberId: memberId, type: isHome ? Type.home : Type.all));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      if (isHome) {
        eventListHome.clear();
        eventListHome.value = jsonDecode(response['body']);
      }
      else {
        eventListAll.clear();
        eventListAll.value = jsonDecode(response['body']);
      }

      print("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR--ELSE-");
    }
  }


  Future getEventDetails({bool showLoader = true, required int eventId}) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getEventDetails(memberId: memberId, eventId:eventId));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();

      eventDetails.clear();
      eventDetails.value = jsonDecode(response['body']);
      print("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR--ELSE-");
    }
  }

  Future addToWishListEvents({
    required int eventId,
    bool showLoader = false,
  }) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.postHttpMethod(
      url: APIEndpoints.wishListAddRemoveEvents,
      data: {
        "eventId": eventId,
        "memberId": memberId,
      },
    );

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      print("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR--ELSE-");
    }
  }

  Future getWishList({bool showLoader = true}) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.getWishList + memberId.toString());

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();

      eventWishList.clear();
      eventWishList.value = jsonDecode(response['body']);

      print("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      eventWishList.clear();
      Print("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR--ELSE-");
    }
  }

  Future joinEvent({
    bool showLoader = true,
    required int eventId,
  }) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response =
    await HttpHandler.getHttpMethod(url: APIEndpoints.joinEvent(eventId: eventId, memberId: memberId));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---SUCCESS---");
      getEventDetails(eventId: eventId);
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();

      Print("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR--ELSE-");
      Toast.errorToast(message: jsonDecode(response['body']));
    }
  }
}
