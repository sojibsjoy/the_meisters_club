import 'package:flutter/material.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import 'package:photo_view/photo_view.dart';
class MultimediaPreviewScreen extends StatefulWidget {
  final Map multiMediaObject;
  const MultimediaPreviewScreen({required this.multiMediaObject});

  @override
  State<MultimediaPreviewScreen> createState() => _MultimediaPreviewScreenState();
}

class _MultimediaPreviewScreenState extends State<MultimediaPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.background,
          body:  Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: appBarForNavigateScreen(title: ""),
              ),
              const SizedBox(height: 4),
              Expanded(child: Center(child:
              PhotoView(
                imageProvider: NetworkImage(widget.multiMediaObject['attachmentUrl']),
              )
             /* Image.network(widget.multiMediaLink)*/))
            ],
          ),
        ));
  }
}
