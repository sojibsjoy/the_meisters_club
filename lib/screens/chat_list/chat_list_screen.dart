import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/image_path_provider/image_path_provider.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../controllers/message/message_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../home/home_screen.dart';
import 'messages/messages_screen.dart';

class ChatListScreen extends StatefulWidget {
  final int roomId;

  const ChatListScreen({required this.roomId});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

final messageScreenController = Get.put(MessageScreenController());

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    print("----roomID--${widget.roomId}");
    initApiCall();

    super.initState();
  }

  initApiCall() {
    messageScreenController.getGroupsOfRoom(roomId: widget.roomId);
  }

  Future onRefresh() async {
    initApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: firstBgWidget(isMemberGroupScreen: true),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: appBarForNavigateScreen(title: "Members groups"),
              ),
              const SizedBox(height: 4),
              Obx(() {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: onRefresh,
                    color: AppColor.pullToRefreshLoader,
                    backgroundColor: AppColor.pullToRefreshBG,
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: messageScreenController.chatGroups.length,
                        itemBuilder: ((context, index) {
                          return chatRoomWidget(
                              isMemberGroupScreen: true,
                              onTap: () async {
                                bool isEligble = messageScreenController
                                        .chatGroups[index]["isEligble"] ??
                                    false;
                                if (isEligble) {
                                  bool isAdded = await messageScreenController
                                      .addParticipantsToGroup(
                                    groupId: messageScreenController
                                        .chatGroups[index]['messageGroupId'],
                                  );
                                  if (isAdded) {
                                    Get.to(() => MessagesScreen(
                                          groupId: messageScreenController
                                                  .chatGroups[index]
                                              ['messageGroupId'],
                                        ));
                                  }
                                } else {
                                  Get.snackbar(
                                    'Access Denied!',
                                    'You are not authorized for this message group.',
                                    icon: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    duration: const Duration(seconds: 2),
                                  );
                                }
                              },
                              title: messageScreenController.chatGroups[index]
                                      ['groupName'] ??
                                  "",
                              subTitle: messageScreenController
                                      .chatGroups[index]['groupDetails'] ??
                                  "",
                              imagePath: messageScreenController
                                      .chatGroups[index]['image'] ??
                                  ImagePath.profileNetImageUnknown);
                        })),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    ));
  }
}
