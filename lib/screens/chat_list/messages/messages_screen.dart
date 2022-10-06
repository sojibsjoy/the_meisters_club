import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xyz/config/date_formator_path_provider/date_formator.dart';
import '../../../config/API/api_endpoints.dart';
import '../../../config/colors_path_provider/colors.dart';
import '../../../config/image_path_provider/image_path_provider.dart';
import '../../../config/storage_key_path_provider/storage_key_path_provider.dart';
import '../../../config/text_style_path_provider/text_style.dart';
import '../../../controllers/message/message_controller.dart';
import '../../../utils/http_handler/network_http.dart';
import '../../../utils/loading_dialog/loading_dialog.dart';
import '../../../utils/storage_preference/shared_preferences_service.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import 'dart:ui' as ui;

import '../multimedia_list_viewer/multimedia_list_viewer_screen.dart';
import '../multimedia_list_viewer/multimedia_preview_screen.dart';

class MessagesScreen extends StatefulWidget {
  final int groupId;

  const MessagesScreen({required this.groupId});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final messageScreenController = Get.put(MessageScreenController());
  int? memberId;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    debugPrint("-----MessagesScreen----");
    Get.find<MessageScreenController>().pageLimit.value = 10;
    Get.find<MessageScreenController>().isPageLoading.value = false;
    Get.find<MessageScreenController>().chatMessages.clear();
    messageScreenController.getMessages(
        groupId: widget.groupId, isInitState: true);
    checkLogin();

    /// PAGINATION
    messageScreenController.scrollController.addListener(() {
      if (messageScreenController.scrollController.position.maxScrollExtent ==
          messageScreenController.scrollController.position.pixels) {
        Get.find<MessageScreenController>().pageLimit.value =
            Get.find<MessageScreenController>().pageLimit.value + 10;
        debugPrint(
            "----${Get.find<MessageScreenController>().pageLimit.value}----");
        Get.find<MessageScreenController>().isPageLoading.value = true;
        messageScreenController
            .getMessages(
                groupId: widget.groupId, isInitState: false, showLoader: false)
            .whenComplete(() {
          Get.find<MessageScreenController>().isPageLoading.value = false;
          // messageScreenController.scrollController.animateTo(
          //     messageScreenController.scrollController.position.maxScrollExtent,
          //     duration: const Duration(milliseconds: 500),
          //     curve: Curves.ease);
        });
      }
    });

    /// TIMER INIT
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => dataLoaderLikeSocket());
  }

  dataLoaderLikeSocket() {
    messageScreenController.getMessages(
        groupId: widget.groupId, isInitState: false, showLoader: false);
  }

  Future checkLogin() async {
    memberId = await getDataFromLocalStorage(
            dataType: StorageKey.integerType,
            storageKey: StorageKey.memberId) ??
        "";
    setState(() {});
    debugPrint(" memerId=== $memberId");
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // List imgList = [
  //   "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  //   "https://i.pinimg.com/474x/01/88/dc/0188dc41881e0e410b5375cdead5f49a.jpg",
  //   "https://thumbs.dreamstime.com/b/rainbow-love-heart-background-red-wood-60045149.jpg",
  //   "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg",
  //   "https://images.ctfassets.net/hrltx12pl8hq/4f6DfV5DbqaQUSw0uo0mWi/6fbcf889bdef65c5b92ffee86b13fc44/shutterstock_376532611.jpg?fit=fill&w=800&h=300",
  //   "https://a1shayari.com/wp-content/uploads/2021/02/Good-Morning-Images-HD-1.jpg"
  // ];

  @override
  Widget build(BuildContext context) {
    // print("---width---------------${Get.width}");
    Image image = Image.network('https://i.stack.imgur.com/lkd0a.png');
    Completer<ui.Image> completer = Completer<ui.Image>();
    print("---width-$completer");
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: Obx(() {
          return messageScreenController.chatMessages.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      height: 10,
                      color: AppColor.accent,
                    ),
                    appBar(
                        profileImage:
                            messageScreenController.chatMessages['image'],
                        title:
                            messageScreenController.chatMessages['groupName'],
                        membersCount: messageScreenController
                            .chatMessages['participantCount']),
                    Container(
                        height: 15,
                        decoration: const BoxDecoration(
                          color: AppColor.accent,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColor.border,
                              width: 1.0,
                            ),
                          ),
                        )),
                    messageScreenController.chatMessages['messages'] != null
                        ? Expanded(
                            child: Container(
                                // color: AppColor.red.withOpacity(0.1),
                                child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                ListView.builder(
                                    controller: messageScreenController
                                        .scrollController,
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 82),
                                    reverse: true,
                                    // shrinkWrap: true,
                                    itemCount: messageScreenController
                                        .chatMessages['messages'].length,
                                    itemBuilder: (context, index) {
                                      return messageScreenController.chatMessages['messages']
                                                  [index]['memberId'] ==
                                              memberId
                                          ? sendMSG(
                                              isText: messageScreenController
                                                  .chatMessages['messages']
                                                      [index]['messageMedia']
                                                  .isEmpty,
                                              textMSG: messageScreenController
                                                      .chatMessages['messages'][index]
                                                          ['messageMedia']
                                                      .isEmpty
                                                  ? messageScreenController.chatMessages['messages']
                                                      [index]['text']
                                                  : "",
                                                  name: messageScreenController
                                                      .chatMessages['messages'][index]
                                                          ['messageMedia']
                                                      .isEmpty
                                                  ? messageScreenController.chatMessages['messages']
                                                      [index]['memberName']
                                                  : "",
                                              imageList: messageScreenController
                                                      .chatMessages['messages']
                                                          [index]['messageMedia']
                                                      .isEmpty
                                                  ? []
                                                  : messageScreenController.chatMessages['messages'][index]['messageMedia'],
                                              time: messageScreenController.chatMessages['messages'][index]['createdAt'],
                                              profileImage: messageScreenController.chatMessages['messages'][index]['image'] ?? ImagePath.profileNetImageApp)
                                          : receivedMSG(
                                              isText: messageScreenController
                                                  .chatMessages['messages']
                                                      [index]['messageMedia']
                                                  .isEmpty,
                                              textMSG: messageScreenController
                                                      .chatMessages['messages']
                                                          [index]
                                                          ['messageMedia']
                                                      .isEmpty
                                                  ? messageScreenController
                                                          .chatMessages[
                                                      'messages'][index]['text']
                                                  : "",
                                              name: messageScreenController
                                                      .chatMessages['messages']
                                                          [index]
                                                          ['messageMedia']
                                                      .isEmpty
                                                  ? messageScreenController
                                                              .chatMessages[
                                                          'messages'][index]
                                                      ['memberName']
                                                  : "",
                                              imageList: messageScreenController
                                                      .chatMessages['messages']
                                                          [index]
                                                          ['messageMedia']
                                                      .isEmpty
                                                  ? []
                                                  : messageScreenController
                                                              .chatMessages[
                                                          'messages'][index]
                                                      ['messageMedia'],
                                              time: messageScreenController
                                                      .chatMessages['messages']
                                                  [index]['createdAt'],
                                              profileImage:
                                                  messageScreenController
                                                                  .chatMessages[
                                                              'messages'][index]
                                                          ['image'] ??
                                                      ImagePath
                                                          .profileNetImageApp,
                                            );
                                    }),
                                if (messageScreenController.isPageLoading.value)
                                  Positioned(
                                    top: 10,
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: AppColor.accent,
                                            borderRadius: circularBorder()),
                                        width: 40,
                                        height: 40,
                                        child: const CircularProgressIndicator(
                                          color: AppColor.primary,
                                          strokeWidth: 2,
                                        )),
                                  )
                              ],
                            )),
                          )
                        : Container(),
                  ],
                )
              : Container();
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColor.accent,
            label: floatingTextField(groupId: widget.groupId),
            onPressed: () {}),
      ),
    );
  }
}

Widget receivedMSG({
  required bool isText,
  required String textMSG,
  required String name,
  required List imageList,
  required String profileImage,
  required String time,
}) {
  return Container(
    // width: Get.width - 170,
    // color: AppColor.green,
    // height: 50,
    margin: const EdgeInsets.only(right: 50, bottom: 16, left: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        profile(profileImage: profileImage),
        Expanded(
          flex: textMSG.length > (Get.width / 12) ? 1 : 0,
          child: Container(
            margin: const EdgeInsets.only(
              left: 5,
            ),
            // width: Get.width - 115,
            padding: isText ? chatPadding : imagePadding,
            decoration: BoxDecoration(
              borderRadius: borderRadius(isSender: false),
              gradient: linearGradientCommon(isStartWithOrange: false),
              // color: AppColor.red,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // crossAxisAlignment: ,
              children: [
                Text(name),
                isText
                    ? Text(
                        textMSG,
                        maxLines: 5,
                        // softWrap: true,
                        style: regular400.copyWith(fontSize: 14),
                      )
                    : multiMediaView(multiMediaList: imageList),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          CustomDateFormator
                              .dateTime_Format_By_MonthName_With_AM_PM(
                                  date: time),
                          style: regular400.copyWith(
                              fontSize: 12, color: AppColor.subFontColor),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 4.57),
                      //   child: SvgPicture.asset(
                      //     ImagePath.check,
                      //     color: AppColor.subFontColor,
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget sendMSG({
  required bool isText,
  required String textMSG,
  required String name,
  required List imageList,
  required String profileImage,
  required String time,
}) {
  return Container(
    // width: Get.width - 170,
    // color: AppColor.green,
    // height: 50,
    margin: const EdgeInsets.only(left: 50, bottom: 16, right: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: textMSG.length > (Get.width / 12) ? 1 : 0,
          child: Container(
            margin: const EdgeInsets.only(right: 5 /*,right: 100*/),
            // width: Get.width - 115,
            padding: isText ? chatPadding : imagePadding,
            decoration: BoxDecoration(
                borderRadius: borderRadius(isSender: true),
                // gradient: linearGradientCommon(),
                color: AppColor.border),
            child: Container(
              // width:Get.width - 115 ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: ,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  isText
                      ? Text(
                          textMSG,
                          maxLines: 100,
                          style: regular400.copyWith(fontSize: 14),
                        )
                      : multiMediaView(multiMediaList: imageList),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            CustomDateFormator
                                .dateTime_Format_By_MonthName_With_AM_PM(
                                    date: time),
                            style: regular400.copyWith(
                                fontSize: 12, color: AppColor.subFontColor),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 4.57),
                        //   child: SvgPicture.asset(
                        //     ImagePath.check,
                        //     color: AppColor.subFontColor,
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        profile(profileImage: profileImage),
      ],
    ),
  );
}

Widget multiMediaView({required List multiMediaList}) {
  return GestureDetector(
    onTap: () {
      if (multiMediaList.length == 1) {
        Get.to(() => MultimediaPreviewScreen(
              multiMediaObject: multiMediaList[0],
            ));
      } else {
        Get.to(MultimediaListViewScreen(
          multimediaList: multiMediaList,
        ));
      }
    },
    child: Container(
        child: Column(
      children: [
        if (multiMediaList.length == 1)
          singleImageViewItem(multiMediaList[0]['attachmentUrl']),
        if (multiMediaList.length >= 2)
          Row(
            children: [
              twoImageViewItem(multiMediaList[0]['attachmentUrl']),
              const SizedBox(
                width: 4,
              ),
              twoImageViewItem(multiMediaList[1]['attachmentUrl']),
            ],
          ),
        if (multiMediaList.length == 3)
          const SizedBox(
            height: 4,
          ),
        if (multiMediaList.length == 3)
          thirdImageViewItem(multiMediaList[2]['attachmentUrl']),
        if (multiMediaList.length >= 4)
          const SizedBox(
            height: 4,
          ),
        if (multiMediaList.length >= 4)
          Row(
            children: [
              twoImageViewItem(multiMediaList[2]['attachmentUrl']),
              const SizedBox(
                width: 4,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  twoImageViewItem(multiMediaList[3]['attachmentUrl']),
                  if (multiMediaList.length > 4)
                    moreImageViewItem(listLength: multiMediaList.length)
                ],
              ),
            ],
          ),
      ],
    )),
  );
}

Widget singleImageViewItem(String image) {
  return SizedBox(
    width: Get.width / 1.5,
    height: Get.width / 1.5,
    child: ClipRRect(
      borderRadius: circularBorder(radius: 5),
      child: Image.network(image, fit: BoxFit.cover),
    ),
  );
}

Widget twoImageViewItem(String image) {
  return SizedBox(
    width: Get.width / 3.5,
    height: Get.width / 3.5,
    child: ClipRRect(
        borderRadius: circularBorder(radius: 5),
        child: Image.network(image, fit: BoxFit.cover)),
  );
}

Widget moreImageViewItem({required int listLength}) {
  return ClipRRect(
    borderRadius: circularBorder(radius: 5),
    child: Container(
      height: Get.width / 3.5,
      width: Get.width / 3.5,
      color: AppColor.background.withOpacity(0.7),
      alignment: Alignment.center,
      child: Text(
        "+ ${listLength - 3}",
        style: regular700.copyWith(fontSize: 18),
      ),
    ),
  );
}

Widget thirdImageViewItem(String image) {
  return SizedBox(
    width: Get.width / 1.75 + 4,
    height: Get.width / 1.75 + 4,
    child: ClipRRect(
      borderRadius: circularBorder(radius: 5),
      child: Image.network(image, fit: BoxFit.cover),
    ),
  );
}

borderRadius({required bool isSender}) {
  return BorderRadius.only(
      topLeft: Radius.circular(isSender ? 10 : 0),
      topRight: Radius.circular(isSender ? 0 : 10),
      bottomLeft: const Radius.circular(10),
      bottomRight: const Radius.circular(10));
}

var chatPadding =
    const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 6);
var imagePadding = const EdgeInsets.only(left: 4, right: 4, bottom: 10, top: 4);

Widget appBar({
  required String title,
  required String profileImage,
  required int membersCount,
}) {
  return Container(
    height: 44,
    width: Get.width,
    color: AppColor.accent,
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: SizedBox(
            width: Get.width / 8,
            // color: AppColor.red,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(ImagePath.arrowBack),
            )),
      ),
      SizedBox(
        width: 45,
        child: Stack(
          children: [
            SizedBox(
                width: 45,
                height: 45,
                child: CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(
                    profileImage,
                  ),
                  backgroundColor: AppColor.background,
                )),
            const Positioned(
                bottom: 2,
                right: 2,
                child: CircleAvatar(
                  backgroundColor: AppColor.blackColor,
                  radius: 5,
                  child: CircleAvatar(
                    backgroundColor: AppColor.onlineIndicator,
                    radius: 4,
                  ),
                ))
          ],
        ),
      ),
      const SizedBox(
        width: 12,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText(title, fontSize: 16),
          subTitleText("$membersCount Members", fontSize: 14)
        ],
      ),
      const Spacer(),
      // Align(
      //   alignment: Alignment.center,
      //   child: Container(
      //     padding: const EdgeInsets.all(10.0),
      //     margin: EdgeInsets.only(right: 10),
      //     child: SvgPicture.asset(ImagePath.more_vert),
      //   ),
      // )
    ]),
  );
}

Future<List> uploadFilesAndGetListOfLink() async {
  print("-----uploadImageAndGetImageLink------");
  List<File> images = [];
  final ImagePicker _picker = ImagePicker();
  final List<XFile>? pickedImages = await _picker.pickMultiImage();
  images.clear();
  if (pickedImages != null) {
    if (pickedImages.isNotEmpty) {
      for (var element in pickedImages) {
        images.add(File(element.path));
      }
    }
  }
  if (images.isNotEmpty) {
    showLoadingDialog();
    final response = await HttpHandler.formHttpMethod(
      methodType: 'POST',
      url: APIEndpoints.uploadFiles,
      multipleFileKey: "files",
      multipleFile: images,
    );

    if (response['error'] == null) {
      hideLoadingDialog();
      debugPrint("---SUCCESS---");
      debugPrint("$response");
      return jsonDecode(response['body']);
    } else {
      hideLoadingDialog();
      debugPrint("---FAIL---");
      return [];
    }
  } else {
    return [];
  }
}

Widget floatingTextField({required int groupId}) {
  final messageScreenController = Get.put(MessageScreenController());
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        color: AppColor.accent.withOpacity(1),
        border:
            const Border(top: BorderSide(color: AppColor.border, width: 1))),
    height: 82,
    child: Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColor.chatBorder),
      ),
      child: Row(children: [
        GestureDetector(
          onTap: () async {
            List filesList = await uploadFilesAndGetListOfLink();
            debugPrint("---$filesList");
            if (filesList.isNotEmpty) {
              FocusManager.instance.primaryFocus?.unfocus();
              await messageScreenController.insertMSG(
                  isTextMSG: false,
                  urlList: filesList,
                  groupId: groupId,
                  showLoader: false);

              messageScreenController.scrollController.animateTo(
                  messageScreenController
                      .scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
          },
          child: Container(
            // color: AppColor.yellowColor,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppColor.chatBorder,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(ImagePath.attach_file),
            ),
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: AppColor.primary,
              controller: messageScreenController.inputTextTEC,
              // cursorHeight: 20,
              decoration: InputDecoration.collapsed(
                hintText: 'Message',
                hintStyle: regular400.copyWith(
                    fontSize: 15, color: AppColor.subFontColor),
              ),

              style: regular400.copyWith(fontSize: 15),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            // debugPrint("---${ GetUtils.isBlank(messageScreenController.inputTextTEC.text)}");
            if (GetUtils.isBlank(messageScreenController.inputTextTEC.text) ==
                true) {
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
              await messageScreenController.insertMSG(
                  isTextMSG: true,
                  groupId: groupId,
                  message: messageScreenController.inputTextTEC.text,
                  showLoader: false);

              messageScreenController.scrollController.animateTo(
                  messageScreenController
                      .scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            }
          },
          child: Container(
            // color: AppColor.yellowColor,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  //                   <--- left side
                  color: AppColor.chatBorder,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(ImagePath.send),
            ),
            width: 50,
            height: 50,
          ),
        )
      ]),
    ),
  );
}
