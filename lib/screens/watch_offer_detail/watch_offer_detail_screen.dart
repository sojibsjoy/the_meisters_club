import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/product/product_controller.dart';
import '../../utils/url_launcher/url_launcher.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../../widgets/custom_button/cutsomButton.dart';
import '../all_event/event_detail/event_detail_screen.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';


class WatchOfferDetailScreen extends StatefulWidget {
  final int productId;

  const WatchOfferDetailScreen({required this.productId});

  @override
  _WatchOfferDetailScreenState createState() => _WatchOfferDetailScreenState();
}

final productController = Get.put(ProductController());

class _WatchOfferDetailScreenState extends State<WatchOfferDetailScreen> {
  Future<void>? _launched;
  @override
  void initState() {
    productController.getProductDetails(productId: widget.productId);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return productController.productDetailsMap.isNotEmpty
            ? Scaffold(
                body: Container(
                  width: Get.width,
                  height: Get.height,
                  color: AppColor.background,
                  child: Stack(
                    children: [
                      /// Background Layout
                      backgroundLayout(
                          imagePath: productController.productDetailsMap
                              ['bannerImage']),

                      ///Data view
                      Positioned(
                        top: Get.height / 2.8,
                        child: Container(
                          width: Get.width,
                          height: Get.height - ((Get.height / 2.8) + 90),
                          // color: AppColor.fontColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: SingleChildScrollView(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(
                                  productController.productDetailsMap
                                          ['tittle'] ??
                                      "",
                                  style: regular600.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "\$ ${productController.productDetailsMap['price'] ?? ""}",
                                  style: regular400.copyWith(fontSize: 16, color: AppColor.fontColor),
                                ),
                                // const SizedBox(
                                //   height: 16,
                                // ),
                                // ratingRowWidget(),
                                watchLabel(link:productController.productDetailsMap
                                ['redirectLink']??""),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                                  child: titleText("Product Description", fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                                  child: Text(
                                    productController.productDetailsMap
                                            ['description'] ??
                                        "",
                                    style: regular400.copyWith(fontSize: 14, color: AppColor.subFontColor),
                                  ),
                                ),
                                productController.productDetailsMap['productImagesResponses']!=null?
                                GridView.count(
                                  scrollDirection: Axis.vertical,           //default
                                  reverse: false,                           //default
                                  controller: ScrollController(),
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                addAutomaticKeepAlives: true,             //default
                                addRepaintBoundaries: true,               //default
                                addSemanticIndexes: true,                 //default
                                semanticChildCount: 0,
                                cacheExtent: 0.0,
                                // dragStartBehavior: DragStartBehavior.start,
                                clipBehavior: Clip.hardEdge,
                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                                crossAxisCount: 3,
                                children: List.generate(productController.productDetailsMap['productImagesResponses'].length, (index) {
                                  return recommendedWatchWidget(image:productController.productDetailsMap['productImagesResponses'][index]['image']);
                                }) // List of Widgets
                            ):Container(),
                                const SizedBox(
                                  height: 12,
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
                        child: eventScreenAppBar(showLikeButton: false),
                      ),
                    ],
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: AppColor.accent,
                    label: const CustomButton(
                        text: 'Contact Now', borderRadiusChange: true, newRadius: 0, isMarginZero: true),
                    onPressed: () async{
                      UrlLauncher.launchLink(productController.productDetailsMap['redirectLink']??"");

                    }),
              )
            : Container();
      }),
    );
  }
  Widget watchLabel({required String link}) {
    return GestureDetector(
      onTap: (){
        UrlLauncher.launchLink(link);
      },child: Container(
        height: 57,
        width: Get.width,
        margin: const EdgeInsets.only(top: 20, bottom: 4),
        decoration: BoxDecoration(color: AppColor.border, borderRadius: circularBorder(radius: 10)),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16), child: Image.asset(ImagePath.watch_label))),
    );
  }
}



Widget recommendedWatchWidget({required String image}) {
  return
    // Row(
    // children: [
    //   for (int i = 0; i < images.length; i++)
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: ClipRRect(
            borderRadius: circularBorder(radius: 5),
            child: Container(
                width: Get.width / 3.65,
                height: Get.width / 3,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
          ),
        );
  //   ],
  // );
}


