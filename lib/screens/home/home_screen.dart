import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/screens/login/login_screen.dart';
import '../../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/event details/event_detail_controller.dart';
import '../../controllers/message/message_controller.dart';
import '../../controllers/news_and_update/news_and_update_controller.dart';
import '../../controllers/offers/offers_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../../widgets/gradient_text/gradient_text.dart';
import '../all_event/all_event_screen.dart';
import '../all_event/event_detail/event_detail_screen.dart';
import '../chat_list/chat_list_screen.dart';
import '../menu/menu_screen.dart';
import '../news_list/news_detail/news_detail_screen.dart';
import '../news_list/news_list_screen.dart';
import '../offer_list/offer_details/offer_details_screen.dart';
import '../offer_list/offer_list_screen.dart';
import '../watch_offer_detail/watch_offer_detail_screen.dart';
import 'package:html/parser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// controllers
final eventDetailsController = Get.put(EventDetailsController());
final newsAndUpdateController = Get.put(NewsAndUpdateController());
final messageScreenController = Get.put(MessageScreenController());
final productController = Get.put(ProductController());
final offersController = Get.put(OffersController());

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    debugPrint("---HOME screen----");
    initApiCall();

    super.initState();
  }

  initApiCall() {
    eventDetailsController.getUpcomingEvents(isHome: true);
    newsAndUpdateController.getNewsAndUpdates(isHome: true, showLoader: false);
    messageScreenController.getChatRooms(showLoader: false);
    productController.getProductList(showLoader: false);
    offersController.getUpcomingOffers(isHome: true, showLoader: true);
  }

  Future onRefresh() async {
    initApiCall();
  }

  @override
  Widget build(BuildContext context) {
    print("----${offersController.offerListHome}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.background,
        drawer: const MenuScreen(),
        key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: firstBgWidget(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: secondBgWidget(),
                ),
                Obx(() {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      appBarTabScreen(
                        onTap1: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        onTap2: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: onRefresh,
                          color: AppColor.pullToRefreshLoader,
                          backgroundColor: AppColor.pullToRefreshBG,
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            children: [
                              eventDetailsController.eventListHome.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 16),
                                      child: labelRow(
                                        "THE 1% EXPERIENCE",
                                        onTap: () {
                                          Print("see All");
                                          Get.to(() => const AllEventScreen());
                                        },
                                      ),
                                    )
                                  : Container(),
                              eventDetailsController.eventListHome.isNotEmpty
                                  ? SizedBox(
                                      height: 290,
                                      // color: AppColor.red,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: eventDetailsController
                                              .eventListHome.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: ((context, index) {
                                            return upComingEventsWidget(
                                              eventId: eventDetailsController
                                                      .eventListHome[index]
                                                  ['eventId'],
                                              image: eventDetailsController
                                                      .eventListHome[index]
                                                  ['homeBanner'],
                                              title: eventDetailsController
                                                      .eventListHome[index]
                                                  ['eventName'],
                                              locationName:
                                                  eventDetailsController
                                                          .eventListHome[index]
                                                      ['location'],
                                              date: eventDetailsController
                                                      .eventListHome[index]
                                                  ['eventDate'],
                                              isLiked: eventDetailsController
                                                      .eventListHome[index]
                                                  ['isWished'],
                                              onTap: () async {
                                                if (Get.find<
                                                        TabScreenController>()
                                                    .isLogin
                                                    .value) {
                                                  eventDetailsController
                                                              .eventListHome[
                                                          index]['isWished'] =
                                                      !eventDetailsController
                                                              .eventListHome[
                                                          index]['isWished'];
                                                  eventDetailsController
                                                      .eventListHome
                                                      .refresh();
                                                  eventDetailsController
                                                      .addToWishListEvents(
                                                          eventId: eventDetailsController
                                                                  .eventListHome[
                                                              index]['eventId']);
                                                } else {
                                                  Get.to(const LoginScreen());
                                                }
                                              },
                                              isFullWidth: false,
                                              isEligble: eventDetailsController
                                                          .eventListHome[index]
                                                      ['isEligble'] ??
                                                  false,
                                            );
                                          })),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                // color: AppColor.red,
                                height: 180, width: Get.width,
                                child: CarouselSlider(
                                  items: productController.sliderList,
                                  carouselController: _controller,
                                  options: CarouselOptions(
                                    // autoPlay: true,
                                    // initialPage: 0,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: false,
                                    aspectRatio: 1.0,
                                    onPageChanged: (index, reason) {
                                      Get.find<ProductController>()
                                          .sliderIndex
                                          .value = index;
                                    },
                                    viewportFraction: 1,
                                    autoPlayAnimationDuration:
                                        const Duration(seconds: 2),
                                    autoPlayCurve: Curves.ease,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              messageScreenController.chatRooms.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 16),
                                      child: labelRow(
                                        "NETWORK WITH THE 1%",
                                        showSeeAll: false,
                                      ),
                                    )
                                  : Container(),
                              messageScreenController.chatRooms.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: messageScreenController
                                          .chatRooms.length,
                                      itemBuilder: ((context, index) {
                                        return chatRoomWidget(
                                            onTap: () {
                                              if (Get.find<
                                                      TabScreenController>()
                                                  .isLogin
                                                  .value) {
                                                Get.to(() => ChatListScreen(
                                                      roomId:
                                                          messageScreenController
                                                                      .chatRooms[
                                                                  index]
                                                              ['messageRoomId'],
                                                    ));
                                              } else {
                                                Get.to(const LoginScreen());
                                              }
                                            },
                                            title: messageScreenController
                                                .chatRooms[index]['name'],
                                            subTitle: messageScreenController
                                                    .chatRooms[index]
                                                ['description'],
                                            imagePath: messageScreenController
                                                .chatRooms[index]['image']);
                                      }))
                                  : Container(),
                              const SizedBox(
                                height: 15,
                              ),
                              offersController.offerListHome.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 16),
                                      child: labelRow(
                                        "PARTNERS DISCOUNT",
                                        onTap: () {
                                          Print("see All");
                                          Get.to(() => const OfferListScreen());
                                        },
                                      ),
                                    )
                                  : Container(),
                              offersController.offerListHome.isNotEmpty
                                  ? SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: offersController
                                            .offerListHome.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return offerWidget(
                                            offerId: offersController
                                                    .offerListHome[index]
                                                ['offerId'],
                                            title: offersController
                                                    .offerListHome[index]
                                                ['companyName'],
                                            offerRate: offersController
                                                .offerListHome[index]
                                                    ['discount']
                                                .toString(),
                                            image: offersController
                                                    .offerListHome[index]
                                                ['companyBanner'],
                                            isEligble: offersController
                                                        .offerListHome[index]
                                                    ['isEligble'] ??
                                                false,
                                          );
                                        },
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 22,
                              ),
                              newsAndUpdateController.newsListHome.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 11),
                                      child: labelRow(
                                        "PARTNERS",
                                        onTap: () {
                                          Print("see All");
                                          Get.to(() => const NewsListScreen());
                                        },
                                      ),
                                    )
                                  : Container(),
                              newsAndUpdateController.newsListHome.isNotEmpty
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: newsAndUpdateController
                                          .newsListHome.length,
                                      // scrollDirection: Axis.horizontal,
                                      itemBuilder: ((context, index) {
                                        return partnersWidget(
                                          index: index,
                                          isAllNews: false,
                                          title: newsAndUpdateController
                                              .newsListHome[index]['eventName'],
                                          subTitle: parse(
                                                  newsAndUpdateController
                                                          .newsListHome[index]
                                                      ['eventDetails'])
                                              .body!
                                              .text,
                                          date: newsAndUpdateController
                                              .newsListHome[index]['eventDate'],
                                          imagePath: newsAndUpdateController
                                                      .newsListHome[index]
                                                  ['homeBanner'] ??
                                              '',
                                        );
                                      }))
                                  : Container(),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget slider() {
  return Obx(
    () {
      return GestureDetector(
        onTap: () {
          if (Get.find<TabScreenController>().isLogin.value) {
            Get.to(() => WatchOfferDetailScreen(
                  productId: productController
                          .productList[productController.sliderIndex.value]
                      ['productId'],
                ));
          } else {
            Get.to(() => const LoginScreen());
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          // color: AppColor.green.withOpacity(0.5),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: Get.width,
                height: 175,
                decoration: BoxDecoration(
                    borderRadius: circularBorder(radius: 10),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.1, 1, 0.1],
                      colors: [
                        AppColor.gradientOrange,
                        AppColor.gradientOrange,
                        AppColor.gradientYellow,
                        AppColor.gradientYellow,
                      ],
                    )),
                child: Row(
                  children: [
                    Container(
                      width: Get.width / 2,
                      // height: 185,
                      // color: AppColor.red,
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(
                              productController.productList[productController
                                      .sliderIndex.value]['tittle'] ??
                                  "",
                              fontSize: 20,
                              isSecondLine: true),
                          const SizedBox(
                            height: 6,
                          ),
                          subTitleText(
                              productController.productList[productController
                                      .sliderIndex.value]['description'] ??
                                  "",
                              fontSize: 14),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: circularBorder(radius: 5),
                              border: Border.all(
                                color: AppColor.fontColor.withOpacity(0.7),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 15),
                              child: Text("View Details",
                                  style: regular400.copyWith(fontSize: 12)),
                            ),
                          ),
                          const Spacer(),
                          if (productController.sliderList.length > 1)
                            SizedBox(
                              height: 15,
                              width: 150,
                              // color: AppColor.green,
                              child: /*Text("${sliderList!.length}"),*/
                                  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < productController.sliderList.length;
                                      i++)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2.5),
                                      width:
                                          productController.sliderIndex.value ==
                                                  i
                                              ? 15
                                              : 5.0,
                                      height: 5.0,
                                      // margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white.withOpacity(
                                          productController.sliderIndex.value ==
                                                  i
                                              ? 1
                                              : 0.6,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 45,
                left: (Get.width / 2) - 70,
                child: SizedBox(
                  width: 80,
                  child: SvgPicture.asset(
                    ImagePath.logo_icon,
                    color: AppColor.fontColor.withOpacity(0.4),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 175,
                  width: Get.width / 2.1,
                  // decoration: BoxDecoration(),
                  // color: AppColor.red,
                  // width: Get.width,

                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      // Positioned(
                      //   top: 5,
                      //   left: 0,
                      //   child: SizedBox(
                      //     width: 130,
                      //     child: SvgPicture.asset(
                      //       ImagePath.logo_icon,
                      //       color: Colors.pink,
                      //       // color: AppColor.fontColor.withOpacity(0.4),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 175,
                            child: Image.network(
                              productController.productList[productController
                                      .sliderIndex.value]['bannerImage'] ??
                                  "",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget upComingEventsWidget({
  required int eventId,
  required String title,
  required String image,
  required String date,
  required String locationName,
  required Function() onTap,
  required bool isLiked,
  required bool isFullWidth,
  required bool isEligble,
  //
}) {
  return GestureDetector(
    onTap: () {
      if (Get.find<TabScreenController>().isLogin.value) {
        if (isEligble) {
          Get.to(() => EventDetailScreen(
                eventId: eventId,
              ))?.whenComplete(() {
            eventDetailsController.getUpcomingEvents(
                isHome: true, showLoader: false);
            eventDetailsController.getUpcomingEvents(
                isHome: false, showLoader: false);
            eventDetailsController.getWishList(showLoader: false);
          });
        } else {
          Get.snackbar(
            'Access Denied!',
            'You are not authorized for this event.',
            icon: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 20),
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.to(() => const LoginScreen());
      }
    },
    child: Container(
// color: AppColor.red,
      margin:
          EdgeInsets.symmetric(horizontal: 8, vertical: isFullWidth ? 12 : 0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 200,
                width: isFullWidth ? Get.width : 340,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 14),
                  width: isFullWidth ? Get.width - 50 : 250,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: regular600.copyWith(
                        color: AppColor.fontColor, fontSize: 17),
                  )),
              const SizedBox(
                height: 7,
              ),
              calenderRowWidget(dateTime: date),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  SvgPicture.asset(ImagePath.location),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    locationName,
                    overflow: TextOverflow.ellipsis,
                    style: regular400.copyWith(
                        color: AppColor.subFontColor, fontSize: 14),
                  ),
                ],
              ),
// Row(
//   children: [
//     Icon(
//       Icons.date_range,
//       color: Colors.orange,
//     ),
//     Text(
//       "10-13 june 2022",
//       style: regular600.copyWith(color: AppColor.whiteColor, fontSize: 18),
//     ),
//   ],
// )
            ],
          ),
          Positioned(
              bottom: 69,
              right: 20,
              child: GestureDetector(
                onTap: onTap,
                child: isLiked
                    ? CircleAvatar(
                        backgroundColor: AppColor.transparent,
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
                    : CircleAvatar(
                        backgroundColor: AppColor.blackColor,
                        child: SvgPicture.asset(
                          ImagePath.favorite_unselected,
                          color: AppColor.primary,
                        ),
                        radius: 20,
                      ),
              )),
        ],
      ),
    ),
  );
}

Widget labelRow(String? title, {bool showSeeAll = true, Function()? onTap}) {
  return Row(
    children: [
      Text(
        title ?? "",
        style: regular700.copyWith(color: AppColor.fontColor, fontSize: 20),
      ),
      const Spacer(),
      if (showSeeAll)
        GestureDetector(
          onTap: onTap,
          child: GradientText(
            "See All",
            gradient: const LinearGradient(
                colors: [AppColor.gradientYellow, AppColor.gradientOrange]),
            style: regular600.copyWith(fontSize: 15),
          ),
        )
    ],
  );
}

Widget offerWidget({
  required int offerId,
  required String title,
  required String image,
  required String offerRate,
  required bool isEligble,
}) {
  return GestureDetector(
    onTap: () {
      if (Get.find<TabScreenController>().isLogin.value) {
        if (isEligble) {
          Get.to(() => OfferDetailScreen(
                offerId: offerId,
              ));
        } else {
          Get.snackbar(
            'Access Denied!',
            'You are not authorized for this offer.',
            icon: const Icon(
              Icons.error,
              color: Colors.red,
            ),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 20),
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        Get.to(() => const LoginScreen());
      }
    },
    child: Container(
      height: 200,
      width: 170,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(children: [
        SizedBox(
          height: 200,
          // decoration: BoxDecoration(
          //     border: Border.all(
          //   color: Colors.grey,
          // )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 128,
            width: Get.width,
            // color: AppColor.red,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.1, 0.1, 1, 0.1],
              colors: [
                AppColor.background.withOpacity(0.7),
                AppColor.background.withOpacity(0.7),
                AppColor.transparent,
                AppColor.transparent,
              ],
            )),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  discountWidget(offerRate: offerRate),
                  SizedBox(width: 150, child: titleText(title, fontSize: 16.0))
                ],
              ),
            )),
      ]),
    ),
  );
}

Widget discountWidget({
  required String offerRate,
}) {
  return Container(
    height: 24,
// width: 200,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: circularBorder(radius: 20),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.7, 0.5, 1, 0],
        colors: [
          AppColor.gradientOrange,
          AppColor.gradientOrange,
          AppColor.gradientYellow,
          AppColor.gradientYellow,
        ],
      ),
    ),
    child: Text(
      "$offerRate% OFF",
      style: regular600.copyWith(color: Colors.white, fontSize: 14),
    ),
  );
}

Widget chatRoomWidget({
  required String imagePath,
  required String title,
  required String subTitle,
  bool isMemberGroupScreen = false,
  required Function() onTap,
}) {
  return Container(
    color: AppColor.transparent,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: 8, vertical: isMemberGroupScreen ? 10 : 5),
        height: 74,
        decoration: BoxDecoration(

            // color: AppColor.red,

            color: AppColor.accent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.border.withOpacity(0.8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 52,
              margin: const EdgeInsets.only(left: 4),
              // color: AppColor.red,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Positioned(
                  //   top: 0,
                  //   left: 5,
                  //   child: SizedBox(
                  //     // width: 500,
                  //     // height: 500,
                  //     // decoration: BoxDecoration(color:AppColor.red,borderRadius: circularBorder),
                  //     child: ClipRRect(
                  //       // borderRadius: circularBorder(),
                  //       child: SvgPicture.asset(
                  //         ImagePath.chat,
                  //         fit: BoxFit.cover,
                  //         color: AppColor.subFontColor.withOpacity(0.5),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                        width: 45,
                        height: 45,
                        // decoration: BoxDecoration(color:AppColor.red,borderRadius: circularBorder),
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 38,
                            fit: BoxFit.fitHeight,
                          ),
                          // CircleAvatar(
                          //   radius: 20,
                          //   backgroundImage: NetworkImage(
                          //     imagePath,
                          //   ),
                          //   backgroundColor: AppColor.background,
                          // ),
                        )),
                  ),
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleText(title),
                    const SizedBox(height: 8),
                    subTitleText(subTitle),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 45,
              height: 45,
              // color: AppColor.red,
              // decoration: BoxDecoration(color:AppColor.red,borderRadius: circularBorder),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: ClipRRect(
                  borderRadius: circularBorder(radius: 0),
                  child: Image.asset(
                    ImagePath.send,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget partnersWidget({
  required int index,
  required bool isAllNews,
  required String imagePath,
  required String title,
  required String subTitle,
  required String date,
}) {
  return GestureDetector(
    onTap: () {
      Get.to(() => NewsDetailScreen(
            index: index,
            isAllNews: isAllNews,
          ));
    },
    child: Container(
      height: 110,
      decoration: BoxDecoration(
          borderRadius: circularBorder(radius: 10), color: AppColor.accent2),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          height: 90,
          width: 93,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imagePath, fit: BoxFit.cover)),
        ),
        // const SizedBox(width: 10,),
        Container(
          width: Get.width / 1.57,
          // color: AppColor.red,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: regular700.copyWith(
                    color: AppColor.fontColor, fontSize: 18),
              ),
              // const Spacer(),
              Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: regular500.copyWith(
                    color: AppColor.subFontColor, fontSize: 12),
              ),
              // const Spacer(),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     SvgPicture.asset(ImagePath.calender),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Text(
              //       date,
              //       textAlign: TextAlign.right,
              //       overflow: TextOverflow.ellipsis,
              //       style: regular400.copyWith(
              //           color: AppColor.subFontColor, fontSize: 14),
              //     ),
              //   ],
              // )
            ],
          ),
        )
      ]),
    ),
  );
}

Widget firstBgWidget({
  bool isMemberGroupScreen = false,
  bool isFirstItemVisible = true,
  bool isSecondItemVisible = true,
}) {
  return Container(
    height: 150,
    width: Get.width,
    margin: EdgeInsets.only(
        top: Get.height / 8, bottom: isMemberGroupScreen ? Get.height / 8 : 0),
    // color: AppColor.red,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: 33,
          top: 8,
          child: isSecondItemVisible
              ? SizedBox(
                  height: 109.5,
                  // width: Get.width,
                  child: SvgPicture.asset(
                    ImagePath.logo_icon,
                    color: AppColor.fontColor.withOpacity(0.06),
                  ))
              : Container(),
        ),
        Positioned(
          left: 0,
          child: isFirstItemVisible
              ? SizedBox(
                  width: Get.width / 1.1,
                  height: 150,
                  child: Image.asset(
                    ImagePath.middleLayer,
                    fit: BoxFit.cover,
                    color: AppColor.primary.withOpacity(0.1),
                  ))
              : Container(),
        ),
      ],
    ),
  );
}

Widget secondBgWidget({
  bool isFirstItemVisible = true,
  bool isSecondItemVisible = true,
}) {
  return Container(
    height: 235,
    width: Get.width,
    margin: EdgeInsets.only(bottom: Get.height / 8),
    // color: AppColor.red,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          top: 80,
          child: isSecondItemVisible
              ? SizedBox(
                  height: 150.5,
                  // width: Get.width,
                  child: Image.asset(
                    ImagePath.bottomLayer,
                    color: AppColor.fontColor.withOpacity(0.06),
                  ))
              : Container(),
        ),
        Positioned(
          left: 0,
          child: isFirstItemVisible
              ? SizedBox(
                  width: Get.width / 1.1,
                  height: 150,
                  child: Image.asset(
                    ImagePath.middleLayer,
                    fit: BoxFit.cover,
                    color: AppColor.primary.withOpacity(0.1),
                  ))
              : Container(),
        ),
      ],
    ),
  );
}
