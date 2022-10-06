import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/API/api_endpoints.dart';
import 'package:xyz/utils/http_handler/network_http.dart';
import 'package:xyz/utils/loading_dialog/loading_dialog.dart';
import '../../widgets/common_widgets/common_widgets.dart';

class NewsAndUpdateController extends GetxController {
  final scrollController = ScrollController();
  RxList<dynamic> newsListHome = [].obs;
  RxList<dynamic> newsListAll = [].obs;

  Future getNewsAndUpdates({bool showLoader = true, required bool isHome}) async {
    if (showLoader) showLoadingDialog();
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getNews_and_Updates( type: isHome ? Type.home : Type.all));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      if(isHome){
        newsListHome.clear();
        newsListHome.value = jsonDecode(response['body']);
      }else{
        newsListAll.clear();
        newsListAll.value = jsonDecode(response['body']);
      }
      print("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader)  hideLoadingDialog();
      Print("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      Print("---ERROR--ELSE-");
    }
  }
}