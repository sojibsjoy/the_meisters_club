import 'package:flutter/cupertino.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../config/text_style_path_provider/text_style.dart';

Widget key_text(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Text(
      text,
      style: regular600.copyWith(
        fontSize: 12,
        color: AppColor.blackColor.withOpacity(0.5),
      ),
    ),
  );
}

Widget value_text({String? text, bool isSecondLine = true,isWhiteFont=false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Text(
      text!,
      style: regular600.copyWith(
          fontSize: 12, color:isWhiteFont?AppColor.whiteColor: AppColor.blackColor.withOpacity(0.8)),
      overflow:isSecondLine?TextOverflow.visible: TextOverflow.ellipsis,
    ),
  );
}