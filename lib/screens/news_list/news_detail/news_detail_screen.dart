import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../config/image_path_provider/image_path_provider.dart';
import '../../../config/text_style_path_provider/text_style.dart';
import '../../../controllers/news_and_update/news_and_update_controller.dart';
import '../../../widgets/common_widgets/common_widgets.dart';

class NewsDetailScreen extends StatefulWidget {
  final int index;
  final bool isAllNews;

  const NewsDetailScreen({required this.index, required this.isAllNews});

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

final newsAndUpdateController = Get.put(NewsAndUpdateController());

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  Map? newsDetails;

  @override
  void initState() {
    newsDetails = widget.isAllNews
        ? newsAndUpdateController.newsListAll[widget.index]
        : newsAndUpdateController.newsListHome[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
        child: Column(children: [
          newsDetailsScreenAppBar(
            index: widget.index,
            title: newsDetails!['eventName'],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: ClipRRect(
                        borderRadius: circularBorder(radius: 10),
                        child: Image.network(
                            newsDetails!['eventImagesResponses'][0]['image'],
                            fit: BoxFit.cover),
                      ),
                    ),
                    // HtmlView(text: newsDetails!['eventDetails']),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 20),
                    //   child: Text(
                    //     'Details',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    HtmlView(text: newsDetails!['eventBigDetails'] ?? ''),
                    // HtmlView(text: newsDetails!['eventDetails']),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}

Widget textView(text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      text,
      style: regular400.copyWith(fontSize: 14, color: AppColor.subFontColor),
    ),
  );
}

Widget importantNotes(String text) {
  return Container(
    // height: 57,
    width: Get.width,
    margin: const EdgeInsets.only(top: 20, bottom: 4),
    decoration: BoxDecoration(
        color: AppColor.border, borderRadius: circularBorder(radius: 10)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: regular400.copyWith(
            fontSize: 14,
            color: AppColor.subFontColor,
            fontStyle: FontStyle.italic),
      ),
    ),
  );
}

Widget newsDetailsScreenAppBar({
  required int index,
  required String title,
}) {
  return Container(
    // height: 44,
    width: Get.width,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    padding: const EdgeInsets.only(bottom: 10),
    color: AppColor.accent,
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: SizedBox(
            width: Get.width / 8.8,
            // color: AppColor.red,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(ImagePath.arrowBack),
            )),
      ),
      const SizedBox(
        width: 12,
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(title, fontSize: 16, isSecondLine: true),
              // calenderRowWidget(dateTime: date)
            ],
          ),
        ),
      ),
    ]),
  );
}
