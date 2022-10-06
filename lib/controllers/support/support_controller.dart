import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../../utils/toast/toast.dart';

class SupportController extends GetxController {
  /// Contact Us
  final nameTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final phoneTEC = TextEditingController();
  final messageTEC = TextEditingController();

  ///
  RxMap aboutMap = {}.obs;

  ///
  submitContactUs() async {
    showLoadingDialog();
    final response = await HttpHandler.postHttpMethod(url: APIEndpoints.contactUsFeedback, data: {
      "fullName": nameTEC.text,
      "email": emailTEC.text,
      "phoneNo": phoneTEC.text,
      "comment": messageTEC.text
    });

    if (response['error'] == null) {
      hideLoadingDialog();
      debugPrint("-----${response['body']}");
      Get.back();
      Toast.successToast(message: "Submitted");
    }
    if (response['error'] != null) {
      hideLoadingDialog();
      Toast.errorToast(message: jsonDecode(response['body']));
    }
  }

  getAboutApp() async {
    showLoadingDialog();
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.getAllInfoOfApp);

    if (response['error'] == null) {
      hideLoadingDialog();
      debugPrint("-----${response['body']}");
      aboutMap.clear();
      aboutMap.value=jsonDecode(response['body'])[0];
    }
    if (response['error'] != null) {
      hideLoadingDialog();
    }
  }
}
