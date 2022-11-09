import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/config/colors_path_provider/colors.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';
import 'package:xyz/widgets/common_widgets/common_widgets.dart';
import '../../../config/image_path_provider/image_path_provider.dart';
import '../../../controllers/offers/offers_controller.dart';
import '../../../widgets/custom_button/cutsomButton.dart';
import '../../all_event/event_detail/event_detail_screen.dart'
    as eventDetailsScrn;
import '../../all_event/event_detail/event_detail_screen.dart';
import '../../home/home_screen.dart';

class OfferDetailScreen extends StatefulWidget {
  final int offerId;

  const OfferDetailScreen({required this.offerId});

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  final _offersController = Get.put(OffersController());

  @override
  void initState() {
    _offersController.getOfferDetails(offerId: widget.offerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("--#--${_offersController.offerDetails['qrCodeLocation']}");
    return SafeArea(
      child: Obx(() {
        return _offersController.offerDetails.isNotEmpty
            ? Scaffold(
                backgroundColor: AppColor.background,
                body: ListView(
                  controller: _offersController.scrollController,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          backgroundLayout(
                            imageList: _offersController
                                .offerDetails['eventImagesResponses'],
                          ),
                          // Positioned(
                          //   top: 0,
                          //   child: SizedBox(
                          //     height: 200,
                          //     width: Get.width,
                          //     child: Image.network(_offersController.offerDetails['companyBanner'],
                          //         fit: BoxFit.cover),
                          //   ),
                          // ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: SizedBox(
                                // height: 200,
                                // width: Get.width,
                                child: SvgPicture.asset(
                                    ImagePath.arrow_back_field),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4),
                      child: titleText(
                          _offersController.offerDetails['companyName'],
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 4),
                      child: locationRowWidget(
                          locationName:
                              _offersController.offerDetails['location']),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: AppColor.border,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_offersController.offerDetails['discount']}% OFF",
                              style: regular500.copyWith(
                                  fontSize: 18, color: AppColor.fontColor),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              _offersController
                                  .offerDetails['companydescription'],
                              style: regular400.copyWith(
                                  fontSize: 14, color: AppColor.subFontColor),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    if (_offersController.offerDetails['isJoinedMember'])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: eventDetailsScrn.youAlreadyGoingWidget(
                            title: "You already Availed"),
                      ),
                    if (_offersController.offerDetails['isJoinedMember'])
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 11),
                        child: labelRow("Items", showSeeAll: false),
                      ),
                    if (_offersController.offerDetails['isJoinedMember'])
                      _offersController.offerDetails['items'] != null
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _offersController
                                  .offerDetails['items'].length,
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: ((context, index) {
                                return foodMenuWidget(
                                    title: _offersController.offerDetails['items']
                                            [index]['tittle'] ??
                                        "",
                                    subTitle: _offersController.offerDetails['items']
                                            [index]['description'] ??
                                        "",
                                    imagePath: _offersController.offerDetails['items']
                                            [index]['bannerImage'] ??
                                        "",
                                    originalPrice: _offersController
                                        .offerDetails['items'][index]['price']
                                        .toString(),
                                    discountedPrice: _offersController
                                        .offerDetails['items'][index]
                                            ['discountPrice']
                                        .toString());
                              }))
                          : Container(),
                    if (_offersController.offerDetails['isJoinedMember'])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: eventDetailsScrn.qrView(
                            image: _offersController
                                .offerDetails['qrCodeLocation']),
                      ),
                  ],
                ),
                bottomNavigationBar:
                    _offersController.offerDetails['isJoinedMember'] == false
                        ? CustomButton(
                            text: 'Avail Offer',
                            borderRadiusChange: true,
                            newRadius: 0,
                            isMarginZero: true,
                            onTap: () {
                              _offersController
                                  .availOffer(
                                offerId: widget.offerId,
                              )
                                  .whenComplete(() {
                                setState(() {
                                  _offersController.scrollController.animateTo(
                                      _offersController.scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                });
                              });
                            },
                          )
                        : null,
              )
            : Container();
      }),
    );
  }
}

Widget foodMenuWidget({
  required String imagePath,
  required String title,
  required String subTitle,
  required String discountedPrice,
  required String originalPrice,
}) {
  return GestureDetector(
    onTap: () {},
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
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: regular700.copyWith(
                    color: AppColor.fontColor, fontSize: 18),
              ),
              const Spacer(),
              Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: regular500.copyWith(
                    color: AppColor.subFontColor, fontSize: 12),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "AED$discountedPrice",
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: regular700.copyWith(
                        color: AppColor.fontColor, fontSize: 14),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "AED$originalPrice",
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: regular400.copyWith(
                        color: AppColor.subFontColor, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    ),
  );
}
