import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../../utils/toast/toast.dart';
import '../tab/tab_screen_controller.dart';

class ProfileController extends GetxController{

  RxMap profileDetailsMap={}.obs;
  RxList userEventsList=[].obs;
  /// profile Update
  TextEditingController nameTEC=TextEditingController();
  TextEditingController aboutTEC=TextEditingController();


  ///

  Future getUserDetails({
    bool showLoader = true,
  }) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get.find<TabScreenController>().isLogin.value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.getUserDetails+memberId.toString());
    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      profileDetailsMap.clear();
      profileDetailsMap.value = jsonDecode(response['body']);
      nameTEC.text=jsonDecode(response['body'])['name'];
      aboutTEC.text=jsonDecode(response['body'])['aboutMember'];
      debugPrint("---SUCCESS---");
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

  Future getUserJoinedEvents({
    bool showLoader = true,
  }) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get.find<TabScreenController>().isLogin.value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.getUserJoinedEvents+memberId.toString());
    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      userEventsList.clear();
      userEventsList.value = jsonDecode(response['body'])['joiningEvents'];
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

  Future updateProfile({bool isName=false,bool  isAbout=false,bool isProfilePic=false,bool isCoverPic=false,String? profileImage}) async {
    showLoadingDialog();
    bool _isLogin = Get
        .find<TabScreenController>()
        .isLogin
        .value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response =await HttpHandler.postHttpMethod(
      url: APIEndpoints.profileUpdate,
      data: {
        "memberId": memberId,
        if(isName)
        "name": nameTEC.text,
        if(isAbout)
        "aboutMember": aboutTEC.text,
        if(isProfilePic)
        "memberImage": profileImage??"",

      }
    );

    if(response['error']==null){
      hideLoadingDialog();
      debugPrint("-----${response['body']}");
      await getUserDetails();
      Toast.successToast(message: "Updated");
    }
    if(response['error']!=null){
      hideLoadingDialog();
      Toast.errorToast( message: jsonDecode(response['body']));
    }



  }

  Future<String?> uploadImageAndGetImageLink()async{

      debugPrint("-----uploadImageAndGetImageLink------");
      final ImagePicker _picker = ImagePicker();
      // Pick an image
      final XFile? image =
      await _picker.pickImage(source: ImageSource.gallery);
      if(image!=null)
      {
        showLoadingDialog();
        final response = await HttpHandler.formHttpMethod(
            methodType: 'POST',
            url: APIEndpoints.uploadFiles,
            multipleFileKey: "files",
            multipleFile: [File(image.path)]);

        if (response['error'] == null) {
          hideLoadingDialog();
          debugPrint("---SUCCESS---");
          debugPrint("$response");
          return jsonDecode(response['body'])[0];
        } else {
          hideLoadingDialog();
          debugPrint("---FAIL---");
          return "";
        }

      }

  }
}