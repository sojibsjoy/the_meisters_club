// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../config/colors.dart';
// import '../../config/text_style.dart';
//
// class CustomSearchTextField extends StatefulWidget {
//   final String hintText;
//   final Icon? suffixIcon;
//   final TextEditingController controller;
//   final TextInputType inputType;
//   final List<TextInputFormatter> limit;
//   final TextCapitalization capitalization;
//
//   // final String titleName;
//   final bool obscureText;
//   final bool isCarTools;
//   final bool isInventory;
//   final bool isSuffixIcon;
//   final bool isEnabled;
//   final int maxlengh;
//   final String manedotory;
//   final String? validationMessage;
//   final FocusNode? fn;
//   final Function(String)? dataCallBack;
//
//   CustomSearchTextField({
//     // required Key key,
//     required this.controller,
//     required this.inputType,
//     required this.hintText,
//     required this.limit,
//     required this.capitalization,
//     // required this.titleName,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.isEnabled = true,
//     this.manedotory = "",
//     this.maxlengh = 200,
//     this.validationMessage,
//     this.fn,
//     this.isSuffixIcon = true,
//     this.dataCallBack, this.isCarTools=false, this.isInventory=false,
//   });
//
//   static String initialSelection = '+91';
//   static List<String> favorite = const [
//     '+1',
//     '+91',
//   ];
//
//   @override
//   State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
// }
//
// class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
//   final focusNode = FocusNode();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     focusNode.addListener(() {
//       print("myFocusNode---${focusNode.hasFocus}");
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return commonTextField();
//   }
//
//   Widget commonTextField() {
//     var radius = 5.0;
//     var borderWidth = 1.0;
//     var whiteColor = AppColor.primaryColor;
//     return CupertinoTextField(
//         cursorHeight: 20,
//         showCursor: false /*historyController.showCursor.value*/,
//         // textAlign: TextAlign.left,
//         autofocus: false,
//         autocorrect: true,
//         // autovalidateMode: AutovalidateMode.onUserInteraction,
//         maxLines: 1,
//         inputFormatters: widget.limit,
//         focusNode: focusNode,
//         // focusNode: widget.fn,
//         obscureText: widget.obscureText,
//         textCapitalization: widget.capitalization,
//         maxLength: widget.maxlengh,
//         textInputAction: TextInputAction.next,
//         style: regular600.copyWith(fontSize: 12, color: whiteColor),
//         keyboardType: widget.inputType,
//         controller: widget.controller,
//         cursorColor: AppColor.primaryColor.withOpacity(1),
//         onTap: (){
//
//         },
//
//         validator: (v) {},
//         onChanged: (v) {
//
//  /*         if(widget.isCarTools)
//           if (carToolsHistoryController.searchController.text.isEmpty) {
//             carToolsHistoryController.searchHistoryList.value = carToolsHistoryController.historyModel.value.payload!.history!;
//           } else {
//             carToolsHistoryController.searchHistoryList.value = carToolsHistoryController.historyModel.value.payload!.history!
//                 .where((element) => element.name!.toLowerCase().contains(v.toLowerCase()))
//                 .toList();
//             setState(() {
//               carToolsHistoryController.showCursor.value = true;
//             });
//           }
//          Get.find<CarToolsHistoryController>().searchHistoryList.refresh();*/
//           //-------------------------------------------------------------------------------------
//
//         },
//         onSaved: (data) {
//           return;
//         },
//
//         decoration: InputDecoration(
//           suffixIcon: Icon(
//             Icons.search,
//             color: AppColor.primaryColor,
//           ),
//           enabled: widget.isEnabled,
//           counterText: '',
//           fillColor: AppColor.accentColor.withOpacity(0.1),
//           filled: true,
//           contentPadding: const EdgeInsets.only(left: 15, top: 0, bottom: 0, right: 8),
//           isDense: true,
//           hintText: widget.hintText,
//           hintStyle: regular400.copyWith(
//             fontSize: 13,
//             color: whiteColor,
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: BorderSide(color: whiteColor, width: borderWidth),
//           ),
//           border: InputBorder.none,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: BorderSide(
//               width: borderWidth,
//               color: whiteColor,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: BorderSide(
//               width: borderWidth,
//               color: whiteColor,
//             ),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: BorderSide(
//               width: borderWidth,
//               color: whiteColor,
//             ),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(radius),
//             borderSide: BorderSide(
//               width: borderWidth,
//               color: whiteColor,
//             ),
//           ),
//         ),
//       );
//
//   }
// }
