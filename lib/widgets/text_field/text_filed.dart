import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../main.dart';

Widget appTextFieldForm({
  TextEditingController? controller,
  int? length,
  iconButton,
  Function(String?)? onChange,
  String? hintText,
  Function? validator,
  Widget? icon,
  int? line,
  bool isLine = false,
  TextInputType? type,
  List<TextInputFormatter>? inputFormatters,
  double? lcPadding,
  double? tcPadding,
  double? rcPadding,
  double? bcPadding,
  double? lPadding,
  double? tPadding,
  double? rPadding,
  double? bPadding,
  bool obscureText = false,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: lPadding ?? 16,
      top: tPadding ?? 8,
      right: rPadding ?? 16,
      bottom: bPadding ?? 8,
    ),
    child: TextFormField(
      maxLines: isLine ? line : 1,
      inputFormatters: inputFormatters,
      maxLength: length,
      onChanged: onChange,
      validator: validator as String? Function(String?)?,
      textInputAction: TextInputAction.done,
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      style: TextStyle(
        color: /*getStorage.read("darkMode") == true
            ? AppColor.lightMode
            :*/ AppColor.darkMode,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: lcPadding ?? 12,
          top: tcPadding ?? 20,
          right: rcPadding ?? 12,
          bottom: bcPadding ?? 20,
        ),
        suffixIcon: iconButton,
        counterText: '',
        prefixIcon: icon,
        filled: true,
        border: const OutlineInputBorder(),
        hintText: hintText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        hintStyle: const TextStyle(
          color: AppColor.darkMode,
        ),
      ),
    ),
  );
}

Widget feedSearchBar({
  TextEditingController? controller,
  Function? onChange,
  Function? onSubmit,
  bool isFilter = false,
  onFilterTap,
  onTap,
  show,
  hintText,
  Widget? icon,
}) {
  return Container(
    height: 40,
    color: Colors.grey.withOpacity(0.1),
    child: Row(
      children: [
        SizedBox(
          width: isFilter == true ? 0 : 16,
        ),
        isFilter == true
            ? icon ??
            IconButton(
              onPressed: onFilterTap,
              icon: const Icon(
                Icons.filter_list_rounded,
                color: AppColor.primary,
              ),
            )
            : const Icon(
          Icons.search,
          color: AppColor.primary,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextField(
            onSubmitted: onSubmit as void Function(String)?,
            onChanged: onChange as void Function(String)?,
            focusNode: FocusNode(
              canRequestFocus: false,
            ),
            textInputAction: TextInputAction.done,
            cursorColor: AppColor.primary,
            style: const TextStyle(
              color: AppColor.primary,
              /*color: getStorage.read("darkMode") == true
                  ? AppColor.textColorWhite
                  : AppColor.textColorBlack,*/
            ),
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hintText ?? "Search...",
              hintStyle: const TextStyle(
                color: AppColor.primary,
              ),
              helperStyle: const TextStyle(
                color: AppColor.primary,
              ),
            ),
          ),
        ),
        show == true
            ? IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.clear,
            color: AppColor.primary,
          ),
        )
            : const SizedBox()
      ],
    ),
  );
}

Widget customTextField({
  String? labelName,
  TextEditingController? controller,
  int? maxLines,
  String? hintText,
  String? counterText,
  double? lcPadding,
  double? tcPadding,
  double? rcPadding,
  double? bcPadding,
  Color? fbColor,
  Color? ebColor,
  bool showNumber = false,
  bool showBfBorder = false,
  bool showBeBorder = false,
  int? maxLength,
  bool isValidate = false,
  String? validationMessage,
  bool isEmailValidator = false,
}) {
  return TextFormField(
    controller: controller,
    focusNode: FocusNode(
      canRequestFocus: false,
    ),
    textInputAction: TextInputAction.done,
    keyboardType: showNumber ? TextInputType.number : TextInputType.text,
    maxLines: maxLines ?? 1,
    maxLength: maxLength,
    validator: isValidate
        ? (value) {
      if (value!.isEmpty) {
        return "$validationMessage is Required !";
      } else if (isEmailValidator == true) {
        if (value.isEmpty) {
          return "$validationMessage is Required !";
        } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Enter Valid $validationMessage';
        }
      }
      return null;
    }
        : null,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(
        left: lcPadding ?? 15,
        top: tcPadding ?? 15,
        right: rcPadding ?? 15,
        bottom: bcPadding ?? 15,
      ),
      labelText: labelName,
      fillColor: Colors.transparent,
      filled: true,
      hintText: hintText ?? "",
      counterText: counterText ?? '',
      hintStyle: const TextStyle(
        color: AppColor.whiteColor,
      ),
      labelStyle: const TextStyle(
        color: AppColor.whiteColor,
      ),
      focusedBorder: showBfBorder
          ? OutlineInputBorder(
        borderSide: BorderSide(
          color: fbColor ?? AppColor.whiteColor,
        ),
      )
          : UnderlineInputBorder(
        borderSide: BorderSide(
          color: fbColor ?? AppColor.whiteColor,
        ),
      ),
      enabledBorder: showBeBorder
          ? OutlineInputBorder(
        borderSide: BorderSide(
          color: fbColor ?? AppColor.whiteColor,
        ),
      )
          : UnderlineInputBorder(
        borderSide: BorderSide(
          color: fbColor ?? AppColor.whiteColor,
        ),
      ),
    ),
  );
}

Widget commonDetailsTextField({
  TextEditingController? controller,
  String? hintText,
  String? labelText,
  String? counterText,
  bool needValidation = false,
  bool? urlValidation = false,
  String? validationMessage,
  double? horizontal,
  iconButton,
  double? vertical,
  double? lcPadding,
  double? tcPadding,
  double? rcPadding,
  double? bcPadding,
  bool readyOnly = false,
  Function? onPressed,
  bool hintTextBold = false,
  bool showBfBorder = true,
  bool showBeBorder = true,
  bool titleTextBold = false,
  bool labelTextBold = false,
  bool fillColor = false,
  bool textAlign = false,
  bool showNumber = false,
  double? hintFontSize,
  double? labelFontSize,
  double? textSize,
  Color? fbColor,
  Color? ebColor,
  Color? hintTextColor,
  Color? labelTextColor,
  Color? textColor,
  int? maxLength,
  int? maxLines,
  List<TextInputFormatter>? inputFormatters,
  TextInputType? keyBoardTypeEnter,
  bool? isPassWordValidation = false,
  bool obscureText = false,
  Function(String?)? onChangedValue,
  TextInputAction? textInputAction,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? 5,
      vertical: vertical ?? 5,
    ),
    child: TextFormField(
      onChanged: onChangedValue,
      obscureText: obscureText,
      controller: controller,
      keyboardType: showNumber ? TextInputType.number : TextInputType.text,
      textAlign: textAlign ? TextAlign.right : TextAlign.start,
      textInputAction: textInputAction ?? TextInputAction.done,
      style: TextStyle(
        color: textColor ?? AppColor.whiteColor,
        fontWeight: titleTextBold ? FontWeight.bold : FontWeight.normal,
        fontSize: textSize ?? 16,
      ),
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: lcPadding ?? 0,
          top: tcPadding ?? 0,
          right: rcPadding ?? 0,
          bottom: bcPadding ?? 0,
        ),
        fillColor: fillColor
            ? AppColor.whiteColor
            : AppColor.whiteColor,
        focusedBorder: showBfBorder
            ? OutlineInputBorder(
          borderSide: BorderSide(
            color: fbColor ?? AppColor.whiteColor,
          ),
        )
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: fbColor ?? AppColor.whiteColor,
          ),
        ),
        enabledBorder: showBeBorder
            ? OutlineInputBorder(
          borderSide: BorderSide(
            color: fbColor ?? AppColor.whiteColor,
          ),
        )
            : UnderlineInputBorder(
          borderSide: BorderSide(
            color: fbColor ?? AppColor.whiteColor,
          ),
        ),
        counterText: counterText == "" ? null : "",
        filled: true,
        suffixIcon: iconButton,
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelTextColor ?? AppColor.whiteColor,
          fontWeight: labelTextBold ? FontWeight.bold : FontWeight.normal,
          fontSize: labelFontSize ?? 16,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor ?? AppColor.whiteColor,
          fontWeight: hintTextBold ? FontWeight.bold : FontWeight.normal,
          fontSize: hintFontSize ?? 16,
        ),
        border: const OutlineInputBorder(),
      ),
      inputFormatters: inputFormatters ?? [],
      onTap: onPressed as void Function()?,
      maxLength: maxLength,
      readOnly: readyOnly,
      validator: needValidation
          ? isPassWordValidation!
          ? (value) {
        if (value!.isEmpty) {
          return '$validationMessage is Required !';
        } else if (value.length < 8) {
          return 'Your password is short !';
        } else if (!RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
            .hasMatch(value)) {
          return 'Your password not contain rules!';
        }
        return null;
      }
          : urlValidation!
          ? (value) {
        if (value!.isEmpty) {
          return '$validationMessage is Required !';
        } else if (!RegExp(
            r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+')
            .hasMatch(value)) {
          return 'Please enter valid URL';
        }
        return null;
      }
          : (value) {
        if (value!.isEmpty) {
          return "$validationMessage is Required !";
        } else {
          return null;
        }
      }
          : null,
    ),
  );
}