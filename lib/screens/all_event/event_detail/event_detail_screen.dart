import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/event details/event_detail_controller.dart';
import '../../../controllers/tab/tab_screen_controller.dart';
import '../../../widgets/custom_button/cutsomButton.dart';
import '../../../config/colors_path_provider/colors.dart';
import '../../../config/image_path_provider/image_path_provider.dart';
import '../../../config/text_style_path_provider/text_style.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import '../../login/login_screen.dart';

class EventDetailScreen extends StatefulWidget {
  final int eventId;

  const EventDetailScreen({
    required this.eventId,
  });

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

/// controllers
final eventDetailsController = Get.put(EventDetailsController());

class _EventDetailScreenState extends State<EventDetailScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? _markerIcon;
  LatLng? _kMapCenter;
  CameraPosition? _kGooglePlex;

  // Map? eventDetails;

  @override
  void initState() {
    print("----INIT-----");
    print("----event id---${widget.eventId}--");
    eventDetailsController.eventDetails.clear();
    initData();
    super.initState();
  }

  initData() async {
    print("-----------------1");
    await eventDetailsController.getEventDetails(eventId: widget.eventId);
    print("-----------------2");

    // eventDetails = eventDetailsController.eventDetails;
    double latitude = double.parse(
        eventDetailsController.eventDetails['latitude'].toString());
    double longitude = double.parse(
        eventDetailsController.eventDetails['longitude'].toString());
    _kMapCenter = LatLng(latitude, longitude);
    _kGooglePlex = CameraPosition(
      target: _kMapCenter!,
      zoom: 17.0,
    );
    setState(() {});
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter!,
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: const MarkerId('marker_1'),
        position: _kMapCenter!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return eventDetailsController.eventDetails.isNotEmpty
            ? Scaffold(
                body: Container(
                  width: Get.width,
                  height: Get.height,
                  color: AppColor.background,
                  child: Stack(
                    children: [
                      /// Background Layout
                      backgroundLayout(
                          imagePath: eventDetailsController
                                  .eventDetails['eventImagesResponses'][0]
                              ['image']),

                      ///Data view
                      Positioned(
                        top: Get.height / 2.8,
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height -
                              ((Get.height / 2.8) +
                                  90 -
                                  (eventDetailsController
                                              .eventDetails['isJoinedMember'] ==
                                          true
                                      ? 60
                                      : 0)),
                          // color: AppColor.fontColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SingleChildScrollView(
                              controller:
                                  eventDetailsController.scrollController,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      eventDetailsController
                                          .eventDetails['eventName'],
                                      style: regular600.copyWith(
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        calenderRowWidget(
                                            dateTime: eventDetailsController
                                                .eventDetails['eventDate']),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: clockRowWidget(
                                                time: eventDetailsController
                                                    .eventDetails['eventTime']))
                                      ],
                                    ),

                                    if (eventDetailsController
                                            .eventDetails['isJoinedMember'] ??
                                        false)
                                      youAlreadyGoingWidget(),
                                    if (eventDetailsController
                                            .eventDetails['isJoinedMember'] ??
                                        false)
                                      qrView(
                                          image: eventDetailsController
                                              .eventDetails['qrCodeLocation']),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 10),
                                      child: titleText("Event description",
                                          fontSize: 16),
                                    ),

                                    ///Description HTML View
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, bottom: 20),
                                      child: HtmlView(
                                          text: eventDetailsController
                                              .eventDetails['eventDetails']),
                                    ),

                                    /// Participants Row
                                    participantRow(
                                        count: eventDetailsController
                                            .eventDetails['participants']),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, bottom: 10),
                                      child:
                                          titleText("Location", fontSize: 16),
                                    ),
                                    locationRowWidget(
                                        locationName: eventDetailsController
                                            .eventDetails['location']),

                                    /// Map view
                                    if (_kMapCenter == null)
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    if (_kMapCenter != null)
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        height: 214,
                                        decoration: BoxDecoration(
                                          // color: AppColor.red.withOpacity(0.09),
                                          borderRadius:
                                              circularBorder(radius: 10),
                                        ),
                                        width: Get.width,
                                        child: GestureDetector(
                                          onTap: () async {
                                            print("----*****");
                                            try {
                                              var availableMaps =
                                                  await mapLauncher.MapLauncher
                                                      .installedMaps;
                                              await availableMaps.first
                                                  .showMarker(
                                                coords: mapLauncher.Coords(
                                                    _kMapCenter!.latitude,
                                                    _kMapCenter!.longitude),
                                                title: eventDetailsController
                                                    .eventDetails['location'],
                                              );
                                            } catch (e) {
                                              Print("--$e");
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                circularBorder(radius: 10),
                                            child: GoogleMap(
                                              mapType: MapType.normal,
                                              initialCameraPosition:
                                                  _kGooglePlex ??
                                                      const CameraPosition(
                                                        target:
                                                            LatLng(0.00, 0.00),
                                                        zoom: 17.0,
                                                      ),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                _controller
                                                    .complete(controller);
                                              },
                                              onTap: (LatLng) async {
                                                debugPrint("-----@@@@@@@@");
                                                try {
                                                  var availableMaps =
                                                      await mapLauncher
                                                          .MapLauncher
                                                          .installedMaps;
                                                  await availableMaps.first
                                                      .showMarker(
                                                    coords: mapLauncher.Coords(
                                                        _kMapCenter!.latitude,
                                                        _kMapCenter!.longitude),
                                                    title:
                                                        eventDetailsController
                                                                .eventDetails[
                                                            'location'],
                                                    // title: "Ocean Beach",
                                                  );
                                                } catch (e) {
                                                  Print("--$e");
                                                }
                                              },
                                              markers: <Marker>{
                                                _createMarker()
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                  ]),
                            ),
                          ),
                        ),
                      ),

                      /// App bar
                      Positioned(
                        top: 16,
                        // right: 16,
                        child: eventScreenAppBar(
                          index: widget.eventId,
                          isLiked:
                              eventDetailsController.eventDetails['isWished'],
                          onTapOfLike: () async {
                            if (Get.find<TabScreenController>().isLogin.value) {
                              eventDetailsController.eventDetails['isWished'] =
                                  !eventDetailsController
                                      .eventDetails['isWished'];
                              eventDetailsController.eventListHome.refresh();
                              eventDetailsController.eventListAll.refresh();
                              eventDetailsController.addToWishListEvents(
                                  eventId: widget.eventId);
                            } else {
                              Get.to(const LoginScreen());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: eventDetailsController
                            .eventDetails['isJoinedMember'] ==
                        false
                    ? FloatingActionButton.extended(
                        label: Container(
                          color: AppColor.green.withOpacity(0.5),
                          child: const CustomButton(
                              text: 'Join Now',
                              borderRadiusChange: true,
                              newRadius: 0,
                              isMarginZero: true),
                        ),
                        onPressed: () async {
                          if (Get.find<TabScreenController>().isLogin.value) {
                            eventDetailsController
                                .joinEvent(
                              eventId: widget.eventId,
                            )
                                .whenComplete(() {
                              setState(() {
                                eventDetailsController.scrollController
                                    .animateTo(
                                        eventDetailsController.scrollController
                                            .position.minScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                              });
                            });
                          } else {
                            Get.to(const LoginScreen());
                          }
                        })
                    : Container(),
              )
            : Container();
      }),
    );
  }
}

Widget youAlreadyGoingWidget({String? title}) {
  return Container(
    height: 40,
    width: Get.width,
    margin: const EdgeInsets.only(top: 20, bottom: 16),
    decoration: BoxDecoration(
        color: AppColor.darkBlueColor,
        borderRadius: circularBorder(radius: 10)),
    child: Row(children: [
      Container(
          margin: const EdgeInsets.only(left: 10, right: 6),
          child: SvgPicture.asset(
            ImagePath.check_circle_svg,
          )),
      Text(
        title ?? "You are already going",
        style: regular600.copyWith(
            fontSize: 16, color: AppColor.blueColor.withOpacity(0.8)),
      )
    ]),
  );
}

Widget qrView({required String image}) {
  return Container(
    height: Get.width - 40,
    width: Get.width,
    margin: const EdgeInsets.only(top: 0, bottom: 4),
    decoration: BoxDecoration(
        color: AppColor.accent,
        borderRadius: circularBorder(radius: 10),
        border: Border.all(color: AppColor.border)),
    child: Container(
        margin: const EdgeInsets.all(19),
        child: Image.network(
          image,
        )),
  );
}

Widget bgThemeWidget({bool isMemberGroupScreen = false}) {
  return Container(
    height: 150,
    width: Get.width,
    margin: const EdgeInsets.only(top: 10),
    // color: AppColor.red,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: -35,
          top: 10,
          child: SizedBox(
              height: 109.5,
              // width: Get.width,
              child: SvgPicture.asset(
                ImagePath.logo_icon,
                color: AppColor.fontColor.withOpacity(0.06),
              )),
        ),
        Positioned(
          left: 0,
          child: SizedBox(
              width: Get.width / 1.1,
              height: 150,
              child: Image.asset(
                ImagePath.middleLayer,
                fit: BoxFit.cover,
                color: AppColor.primary.withOpacity(0.1),
              )),
        ),
      ],
    ),
  );
}

Widget participantRow({required int count}) {
  return Container(
    height: 56,
    width: Get.width,
    decoration: BoxDecoration(
        color: AppColor.accent,
        borderRadius: circularBorder(radius: 10),
        border: Border.all(color: AppColor.border)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "$count  participants",
            style: regular400.copyWith(fontSize: 16),
          ),
        ),
        /*  Container(
          height: 100,
          width: Get.width / 2.3,
          // color: AppColor.red,
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(right: 8),
          child: Container(
            width: 145,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                for (int i = 1; i <= (imagesListNet.length >= 4 ? 4 : imagesListNet.length); i++)
                  Positioned(
                    left: 27 * i.toDouble(),
                    child: Container(
                      height: 36,
                      width: 36,
                      child: (imagesListNet.length > 4 && i == 4)
                          ? lastProfile(
                              profileImage: ImagePath.profileNetImage,
                              radius: 36,
                              isBorder: true,
                            )
                          : profile(profileImage: ImagePath.profileNetImageME, radius: 36, isBorder: true),
                    ),
                  ),
              ],
            ),
          ),
        )*/
      ],
    ),
  );
}

Widget eventScreenAppBar({
  int? index,
  bool showLikeButton = true,
  Function()? onTapOfLike,
  bool? isLiked,
}) {
  return Container(
      // color: Colors.blue,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: Get.width - 16,
      // height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                  height: 36,
                  width: 36,
                  child: SvgPicture.asset(ImagePath.arrow_back_field))),
          if (showLikeButton)
            GestureDetector(
              onTap: onTapOfLike,
              child: SizedBox(
                height: 36,
                width: 36,
                child: isLiked == true
                    ? CircleAvatar(
                        backgroundColor: AppColor.blackColor,
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return const RadialGradient(
                              center: Alignment.topLeft,
                              radius: 0.5,
                              colors: [
                                AppColor.gradientOrange,
                                AppColor.yellowColor,
                              ],
                              tileMode: TileMode.mirror,
                            ).createShader(bounds);
                          },
                          child: SvgPicture.asset(ImagePath.fav_fill_outlined),
                        ),
                        // radius: 20,
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(ImagePath.circle_border),
                          SvgPicture.asset(ImagePath.favorite_unselected,
                              color: AppColor.primary, width: 16.67),
                        ],
                      ),
              ),
            ),
        ],
      ));
}

Widget backgroundLayout({required String imagePath}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      ///image view
      Positioned(
        top: 0,
        child: SizedBox(
          // color: Colors.green,
          height: Get.height / 2.8,
          width: Get.width,
          child: Image.network(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),

      /// background image view
      Positioned(
        top: Get.height / 2.8 - 30,
        child: Container(
          width: Get.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: circularBorderParticular(topLeft: 25, topRight: 25),
          ),
          child: bgThemeWidget(),
        ),
      ),
    ],
  );
}
