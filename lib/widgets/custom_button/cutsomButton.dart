import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Color? color;
  final Color fontColor;
  final Color borderColor;
  final double newRadius;
  final bool fontColorChange;
  final bool borderColorChange;
  final bool borderRadiusChange;
  final bool isMarginZero;

  const CustomButton(
      {
      // required Key key,
      required this.text,
      this.color,
      this.fontColor = Colors.white,
      this.borderColor = Colors.transparent,
      this.newRadius = 0,
      this.fontColorChange = false,
      this.isMarginZero = false,
      this.borderColorChange = false,
      this.borderRadiusChange = false, this.onTap});

  // : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var startColor = Color(0xffFE6915);
    // var endColor = Color(0xffF6B323);
    return GestureDetector(
    onTap:onTap,
      child: Container(
        height: 60,
        width: isMarginZero?MediaQuery.of(context).size.width:MediaQuery.of(context).size.width-20,
        margin: EdgeInsets.only(bottom: isMarginZero?12:0),
        decoration: BoxDecoration(
          // color:AppColor.transparent,
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
          ),
          borderRadius: borderRadiusChange ? BorderRadius.circular(newRadius) : BorderRadius.circular(10),
          border: borderColorChange
              ? Border.all(color: borderColor, width: 1)
              : Border.all(color: AppColor.transparent, width: 1),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: regular600.copyWith(
                  fontSize: 16,
                  color: fontColorChange ? fontColor : AppColor.fontColor,
                ),
              ),
             const SizedBox(width: 16,),
             Container(color: AppColor.transparent,child: SvgPicture.asset(ImagePath.arrowRight,width: 16,height: 12,))
            ],
          ),
        ),
      ),
    );
  }
}
