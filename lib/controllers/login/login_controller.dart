import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../screens/login/otp_screen.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../../utils/toast/toast.dart';
import '../tab/tab_screen_controller.dart';

class LoginController extends GetxController{

  final emailTEC=TextEditingController();
  final OTP_TEC=TextEditingController();

  Future loginSendOtpToEmail() async {
    showLoadingDialog();
    final response =await HttpHandler.postHttpMethod(
        url: APIEndpoints.sendOtpToEmail+emailTEC.text,
    );

    if(response['error']==null){
      hideLoadingDialog();
      debugPrint("-----${response['body']}");
      Get.to( OTPScreen(email: emailTEC.text,));

    }
    if(response['error']!=null){
      hideLoadingDialog();
      Toast.errorToast( message: jsonDecode(response['body']));
    }



  }

  Future verifyOTP() async {
    showLoadingDialog();
    // String deviceId=await getDataFromLocalStorage(dataType: StorageKey.stringType, storageKey: StorageKey.deviceId)??"";

    String deviceId= await FirebaseMessaging.instance.getToken()??"";
    final response =await HttpHandler.postHttpMethod(
        url: APIEndpoints.verifyOTP(email: emailTEC.text, otp: OTP_TEC.text, deviceId: deviceId),
    );

    if(response['error']==null){
      hideLoadingDialog();
      debugPrint("-----${response['body']}");

      var resData=jsonDecode(response['body']);
      //
      await setDataToLocalStorage(dataType: StorageKey.boolType, storageKey: StorageKey.isLogin,boolData: true);
      await setDataToLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId,integerData:resData['memberId'] );
      await setDataToLocalStorage(dataType: StorageKey.stringType, storageKey: StorageKey.memberToken,stringData: resData['token'] );
      await setDataToLocalStorage(dataType: StorageKey.stringType, storageKey: StorageKey.memberKey,stringData:resData['memberKey'] );
      //
      await setDataToLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.packageId,integerData:resData['packageId'] );
      await setDataToLocalStorage(dataType: StorageKey.stringType, storageKey: StorageKey.packageName,stringData:resData['packages']['packageName'] );
      await setDataToLocalStorage(dataType: StorageKey.stringType, storageKey: StorageKey.packageColor,stringData: fixColorCodeFor(colorCode: resData['packages']['color']) );
      Get.find<TabScreenController>().isLogin.value=true;
      Get.find<TabScreenController>().diamondColorString.value=fixColorCodeFor(colorCode: resData['packages']['color']);
      //
      Get.back();
      Get.back();
      Toast.successToast(message: "Login Success");
    }
    if(response['error']!=null){
      hideLoadingDialog();
      Toast.errorToast( message: jsonDecode(response['body']));
    }



  }
}