
import 'package:flutter/material.dart';
import 'package:xyz/config/colors_path_provider/colors.dart';

Widget refreshIndicatorCommon({required Function() onRefresh,required Widget child}){
  return RefreshIndicator(
      onRefresh: onRefresh(),
      color: AppColor.primary,
      child:child,
  );
}