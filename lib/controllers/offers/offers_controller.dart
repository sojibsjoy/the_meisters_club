import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../../utils/toast/toast.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../tab/tab_screen_controller.dart';

class OffersController extends GetxController{
  final scrollController = ScrollController();
  RxList<dynamic> offerListHome = [].obs;
  RxList<dynamic> offerListAll = [].obs;

  //
  RxMap offerDetails = {}.obs;

  Future getUpcomingOffers({bool showLoader = true, required bool isHome}) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getOffers(memberId: memberId, type: isHome ? Type.home : Type.all));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      if (isHome) {
        offerListHome.clear();
        offerListHome.value = jsonDecode(response['body']);
        offerListHome.refresh();
      }
      else {
        offerListAll.clear();
        offerListAll.value = jsonDecode(response['body']);
        offerListAll.refresh();
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


  Future getOfferDetails({bool showLoader = true, required int offerId}) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getOfferDetails(memberId: memberId, offerId: offerId));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();

      offerDetails.clear();
      offerDetails.value = jsonDecode(response['body']);
      offerDetails.refresh();
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

  Future availOffer({
    bool showLoader = true,
    required int offerId,
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
    await HttpHandler.getHttpMethod(url: APIEndpoints.availOffer(offerId:  offerId, memberId: memberId));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---SUCCESS---");
      getOfferDetails(offerId: offerId);
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