import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/API/api_endpoints.dart';
import '../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../utils/http_handler/network_http.dart';
import '../../utils/loading_dialog/loading_dialog.dart';
import '../../utils/login_checker/login_checker.dart';
import '../../utils/storage_preference/shared_preferences_service.dart';
import '../../utils/toast/toast.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../tab/tab_screen_controller.dart';

class MessageScreenController extends GetxController {
  ///
  final inputTextTEC = TextEditingController();
  final scrollController = ScrollController();

  ///
  RxList<dynamic> chatRooms = [].obs;
  RxList<dynamic> chatGroups = [].obs;
  RxMap<String, dynamic> chatMessages = <String, dynamic>{}.obs;

  /// scroll var
  RxInt pageLimit = 10.obs;
  RxBool isPageLoading = false.obs;

  ///--------------------------------------------------------API---------------------------------------------------------
  Future getChatRooms({
    bool showLoader = true,
  }) async {
    if (showLoader) showLoadingDialog();
    // bool _isLogin = await isLogin();
    // int memberId = _isLogin
    //     ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
    //     : 0;
    final response = await HttpHandler.getHttpMethod(url: APIEndpoints.getAllChatRooms);

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      chatRooms.clear();
      chatRooms.value = jsonDecode(response['body']);

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

  Future getGroupsOfRoom({bool showLoader = true, required int roomId}) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get.find<TabScreenController>().isLogin.value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getParticularChatRoomGroups(roomId: roomId, memberId: memberId));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      chatGroups.clear();
      chatGroups.value = jsonDecode(response['body']);
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

  Future<bool> addParticipantsToGroup({
    bool showLoader = true,
    required int groupId,
  }) async {
    if (showLoader) showLoadingDialog();
    bool _isLogin = Get.find<TabScreenController>().isLogin.value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.addParticipantsToGroup(groupId: groupId, memberId: memberId));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---SUCCESS---");
      debugPrint("---${jsonDecode(response['body'])}---");
      debugPrint("---${jsonDecode(response['body'])['key']}---");
      debugPrint("---${jsonDecode(response['body'])['value']}---");
      if (jsonDecode(response['body'])['key'] == false) {
        Toast.warningToast(message: jsonDecode(response['body'])['value'], title: "Group");
      }
      return jsonDecode(response['body'])['key'];
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR---");
      return false;
    } else {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR--ELSE-");
      return false;
    }
  }

  Future getMessages({bool showLoader = true, required int groupId, required bool isInitState}) async {
    if (showLoader) showLoadingDialog();
    final response = await HttpHandler.getHttpMethod(
        url: APIEndpoints.getMessages(groupId: groupId, page: 0, pageSize: pageLimit.value));

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---#${jsonDecode(response['body'])}");

      /// reverse list
      /*   List<dynamic> ?reversedList ;
      if(jsonDecode(response['body'])['messages']!=null) {
        var myList = jsonDecode(response['body'])['messages'];
        //initialize a new list from iterable to the items of reversed order
         reversedList = List.from(myList.reversed);
      }*/
      if (isInitState) {
        chatMessages.value = jsonDecode(response['body']);
      } else {
        if (jsonDecode(response['body'])['messages'] != null) {
          chatMessages['messages'] = jsonDecode(response['body'])['messages'];
        }
      }
      chatMessages.refresh();
      debugPrint("---SUCCESS---");
    }

    /// Error
    else if (response['error'] != null) {
      if (showLoader) hideLoadingDialog();
      if (isInitState) chatMessages.clear();
      debugPrint("---ERROR---");
    } else {
      if (showLoader) hideLoadingDialog();
      debugPrint("---ERROR--ELSE-");
    }
  }

  Future insertMSG({
    bool showLoader = false,
    String? message,
    List? urlList,
    required bool isTextMSG,
    required int groupId,
    // required int messageId,
  }) async {
    if (showLoader) showLoadingDialog();
    inputTextTEC.clear();
    bool _isLogin = Get.find<TabScreenController>().isLogin.value;
    int memberId = _isLogin
        ? await getDataFromLocalStorage(dataType: StorageKey.integerType, storageKey: StorageKey.memberId)
        : 0;
    final response = await HttpHandler.postHttpMethod(
      url: APIEndpoints.insertMessage,
      data: {
        // "messageId": 0,
        "memberId": memberId,
        "messageGroupId": groupId,
        if (message != null || isTextMSG) "text": message,
        // "parentMessageId": 0,
        if (!isTextMSG)
          "messageMedia": List.generate(
              urlList!.length,
              (index) =>
                    {"mediaType": "Image", "attachmentUrl": urlList[index].toString()}
                  ),
        "textType": isTextMSG ? "Text" : "Multimedia"

        ///Multimedia,Text
      },
    );

    /// Success
    if (response['error'] == null) {
      if (showLoader) hideLoadingDialog();
      debugPrint("---SUCCESS---");
      await getMessages(
        groupId: groupId,
        showLoader: false,
        isInitState: false,
      );
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
