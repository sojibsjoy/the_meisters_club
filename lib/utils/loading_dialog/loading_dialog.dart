import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:xyz/config/image_path_provider/image_path_provider.dart';

void showLoadingDialog({
  Color? barrierColor,
}) {
  Future.delayed(const Duration(seconds: 0), () {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [

                        Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 100,
                            child: Lottie.asset(ImagePath.loader_lottie_json)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  });
}

void hideLoadingDialog() {
  Navigator.pop(Get.context!, false);
}
