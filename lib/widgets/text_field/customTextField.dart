import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/text_style_path_provider/text_style.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final List<TextInputFormatter> limit;
  final TextCapitalization capitalization;
  final bool obscureText;
  final int maxlengh;
  final String? validationMessage;

  // final bool needValidation;

  final bool nameValidator;
  final bool tokenValidator;
  final bool phoneValidator;
  final bool emailValidator;
  final bool otpValidator;
  final bool textAreaValidator;
   CustomTextField({
    // required Key key,
    required this.controller,
    required this.inputType,
    required this.hintText,
    required this.limit,
    required this.capitalization,
    this.obscureText = false,
    this.maxlengh = 200,

    //
    this.validationMessage,
    this.nameValidator = false,
    this.tokenValidator = false,
    this.phoneValidator = false,
    this.emailValidator = false,
    this.otpValidator = false,
    this.textAreaValidator = false,

  });

  @override
  Widget build(BuildContext context) {
    double borderRadius=10;
    return
      SizedBox(
        width: Get.width-20,
        child: TextFormField(
            textAlign: TextAlign.left,
            autofocus: false,
            autocorrect: true,

            maxLines: textAreaValidator?null:1,
            minLines: textAreaValidator?6:1,
            inputFormatters: limit,
            obscureText: obscureText,
            textCapitalization: capitalization,
            maxLength: maxlengh,
            textInputAction: TextInputAction.next,
            style: regular600.copyWith(fontSize: 16,color: AppColor.fontColor),
            keyboardType: inputType,
            controller: controller,
            cursorColor: AppColor.primary,

            validator: (v) {
              if (v!.isEmpty) {
                return "$validationMessage";
              }
              else if (nameValidator) {
                if (v.length < 2 ) {
                  return "$validationMessage";
                }
              }else if (tokenValidator) {
                if (v.isEmpty ) {
                  return "$validationMessage";
                }
              }else if (otpValidator) {
                if (v.isEmpty ) {
                  return "OTP can't be empty";

                }else if(v.length>4) {
                  return "OTP length must be 4";
                }
              } else if (phoneValidator ) {
                if( !GetUtils.isPhoneNumber(v)) {
                  return "$validationMessage";
                }
              } else if (emailValidator) {
               if( !GetUtils.isEmail(v)) {
                 return "$validationMessage";
               }

              }  else {
                null;
              }
              return null;
            },
            onSaved: (data) {
            },
            decoration: InputDecoration(
              errorStyle: regular500.copyWith(fontSize: 10,color: AppColor.primary),
              counterText: '',
              fillColor: AppColor.accent,
              filled: true,
              contentPadding:
              const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
              isDense: true,
              hintText: hintText,
              hintStyle: regular700.copyWith(
                fontSize: 15,
                color: AppColor.textFieldHintFontColor,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.textFieldBorder,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: AppColor.textFieldBorder, width: 1.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: AppColor.textFieldBorder, width: 1.0),
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  width: 1,
                  color:  AppColor.textFieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  width: 1,
                  color:  AppColor.textFieldBorder,
                ),
              ),
            ),
          ),
      );

  }
}
