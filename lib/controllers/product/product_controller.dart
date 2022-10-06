

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/API/api_endpoints.dart';
import '../../screens/home/home_screen.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';

class ProductController extends GetxController{


  RxList<dynamic> productList = [].obs;
  List<Widget> sliderList = <Widget>[];
  RxInt sliderIndex = 0.obs;

  //Product Details
  RxMap productDetailsMap = {}.obs;


  Future getProductList({
    bool showLoader = true,
  }) async {
    if (showLoader) showLoadingDialog();
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.productBanner);
    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      productList.clear();
      sliderList.clear();
      sliderIndex.value=0;
      productList.value = jsonDecode(response['body']);
      productList.forEach((element) {
        sliderList.add(slider());
      });

      print("---SUCCESS---");
    }
    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR--ELSE-");
    }
  }

  Future getProductDetails({
    bool showLoader = true,required int productId
  }) async {
    if (showLoader) showLoadingDialog();
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.productDetails+productId.toString());
    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      productDetailsMap.clear();
      productDetailsMap.value = jsonDecode(response['body']);
      print("---SUCCESS---");
    }
    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR--ELSE-");
    }
  }
}