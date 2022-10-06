import '../../config/colors_path_provider/colors.dart';
import 'package:flutter/cupertino.dart';
import '../../config/text_style_path_provider/text_style.dart';

class AlertDialogCommon extends StatefulWidget {
  final String title;
  final Function() yesOnTap;
  final Function() noOnTap;
  const AlertDialogCommon({required this.title,required this.yesOnTap,required this.noOnTap});

  @override
  State<AlertDialogCommon> createState() => _AlertDialogCommonState();
}

class _AlertDialogCommonState extends State<AlertDialogCommon> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      insetAnimationCurve:Curves.decelerate,
      title: Center(
        child: Text(
         widget.title,
          style: regular600.copyWith(
              fontSize: 16),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap:
              widget.yesOnTap,
              child: Container(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                alignment:
                Alignment.center,
                child: Text(
                 "Yes",
                  style: regular500
                      .copyWith(
                      fontSize: 16,
                      color: AppColor
                          .blackColor),
                ),
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap:  widget.noOnTap,
              child: Container(
                padding:
                const EdgeInsets
                    .symmetric(
                    horizontal: 20,
                    vertical: 10),
                alignment:
                Alignment.center,
                child: Text(
                 "No",
                  style: regular500
                      .copyWith(
                      fontSize: 16,
                      color: AppColor
                          .blueColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
