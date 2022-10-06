import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import 'multimedia_preview_screen.dart';

class MultimediaListViewScreen extends StatefulWidget {
  final List multimediaList;

  const MultimediaListViewScreen({required this.multimediaList});

  @override
  State<MultimediaListViewScreen> createState() => _MultimediaListViewScreenState();
}

class _MultimediaListViewScreenState extends State<MultimediaListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: appBarForNavigateScreen(title: ""),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount: widget.multimediaList.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                        onTap: () => Get.to(
                              () => MultimediaPreviewScreen(
                                multiMediaObject: widget.multimediaList[index],
                              ),
                            ),
                        child: Image.network(widget.multimediaList[index]['attachmentUrl'])),
                  );
                })),
          )
        ],
      ),
    ));
  }
}
