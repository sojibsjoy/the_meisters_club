import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../controllers/news_and_update/news_and_update_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../home/home_screen.dart';
import 'package:html/parser.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

final newsAndUpdateController = Get.put(NewsAndUpdateController());

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void initState() {
    initApiCall();
    super.initState();
  }

  initApiCall() {
    newsAndUpdateController.getNewsAndUpdates(isHome: false);
  }

  Future onRefresh() async {
    initApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: appBarForNavigateScreen(title: "Partners"),
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
                    //   shrinkWrap: true,
                    itemCount: newsAndUpdateController.newsListAll.length,
                    itemBuilder: ((context, index) {
                      return partnersWidget(
                        index: index,
                        isAllNews: true,
                        title: newsAndUpdateController.newsListAll[index]
                            ['eventName'],
                        subTitle: parse(newsAndUpdateController
                                .newsListAll[index]['eventDetails'])
                            .body!
                            .text,
                        date: newsAndUpdateController.newsListAll[index]
                            ['eventDate'],
                        imagePath: newsAndUpdateController.newsListAll[index]
                                ['homeBanner'] ??
                            '',
                      );
                    })),
              ),
            );
          }),
        ],
      ),
    ));
  }
}
