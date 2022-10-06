// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
//
// class NotificationProvider {
//
//   static void initialize_AwesomeNotifications(){
//     AwesomeNotifications().initialize(
//       // set the icon to null if you want to use the default app icon
//         'resource://drawable/res_app_icon',
//         [
//           NotificationChannel(
//               channelGroupKey: 'basic_channel_group',
//               channelKey: 'basic_channel',
//               channelName: 'Basic notifications',
//               channelDescription: 'Notification channel for basic tests',
//               defaultColor: Color(0xFF9D50DD),
//               ledColor: Colors.white)
//         ],
//         // Channel groups are only visual and are not required
//         // channelGroups: [
//         //   NotificationChannelGroup(
//         //       channelGroupkey: 'basic_channel_group',
//         //       channelGroupName: 'Basic group')
//         // ],
//         // debug: true
//     );
//   }
//
//   /// Check Permission
//   static void checkAndRequestNotificationPermission() {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         // This is just a basic example. For real apps, you must show some
//         // friendly dialog box before call the request method.
//         // This is very important to not harm the user experience
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }
//
//   /// onTap Detector
//   static void notificationOnTapDetector() {
//     AwesomeNotifications().actionStream.listen((ReceivedNotification receivedNotification) {
//       print("---------------ONTAP-----------");
//     });
//   }
//
//   /// Create Notification
//   static void createNotification({
//     required int id,
//     required String channelKey,
//     required String title,
//     required String body,
//   }) {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(id: id, channelKey: channelKey, title: title, body: body));
//   }
// }
