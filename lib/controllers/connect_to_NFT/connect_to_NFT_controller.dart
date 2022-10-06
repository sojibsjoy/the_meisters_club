import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xyz/config/API/api_endpoints.dart';
import 'package:xyz/screens/register_account/register_account_screen.dart';
import 'package:xyz/utils/http_handler/network_http.dart';
import 'package:xyz/utils/loading_dialog/loading_dialog.dart';
import 'package:xyz/utils/toast/toast.dart';

class ConnectToNftController extends GetxController {
  final tokenNumberTEC = TextEditingController();

  Future connectToNftVerification() async {
    showLoadingDialog();
    final response =await HttpHandler.postHttpMethod(
      url: APIEndpoints.connectToNftVerification+tokenNumberTEC.text,
    );

    if(response['error']==null){
      hideLoadingDialog();
      print("-----${response['body']}");
      Get.to(()=> RegisterAccountScreen(memberId: jsonDecode(response['body'])['memberId'],));
    }
    if(response['error']!=null){
      hideLoadingDialog();
    Toast.errorToast( message: jsonDecode(response['body']));

    }



  }
}
