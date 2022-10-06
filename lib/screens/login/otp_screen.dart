import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/screens/tab%20screen/tab%20screen.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/login/login_controller.dart';
import '../../widgets/custom_button/cutsomButton.dart';
import '../../widgets/text_field/customTextField.dart';
import '../connect_NFT/connect_NFT_screen.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  double fixedSpace = 17.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
          // alignment: const Alignment(-0.4, 0.6),
          children: [
            backgroundThemeWidget(sideLayerImagePath: ImagePath.sideLayerCropped),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(ImagePath.arrow_back_field),
                    ),
                  ),
                  Expanded(
                    child: SafeArea(
                      child: Container(
                        // height: Get.width,
                        width: Get.width,
                        // alignment: Alignment.center,
                        // color: Colors.pink,
                        child: SingleChildScrollView(
                          child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              authScreensLogo(),
                              const SizedBox(height: 80,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Verify OTP",
                                  textAlign: TextAlign.center,
                                  style: regular600.copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "OTP sent to ${widget.email}",
                                textAlign: TextAlign.center,
                                style: regular400.copyWith(fontSize: 16, color: AppColor.subFontColor),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              CustomTextField(
                                controller: loginController.OTP_TEC,
                                otpValidator: true,
                                validationMessage: "OTP can't be empty",
                                inputType: TextInputType.phone,
                                hintText: "Enter OTP",
                                limit: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                capitalization: TextCapitalization.none,
                              ),
                              SizedBox(
                                height: fixedSpace,
                              ),
                              CustomButton(
                                text: 'Verify',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("---Verify---");
                                    loginController.verifyOTP();
                                  }
                                },
                              ),
                              SizedBox(
                                height: fixedSpace,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Expanded(
                                  // flex: 0,
                                  child: Text(
                                    "If you don't receive an OTP,",
                                    textAlign: TextAlign.center,
                                    style: regular400.copyWith(fontSize: 14, color: AppColor.subFontColor),
                                  ),
                                ),GestureDetector(
                                 onTap: (){
                                   loginController.loginSendOtpToEmail();
                                 }, child: Container(
                                    width: 105,
                                    child: Text(
                                      "Resend",
                                      textAlign: TextAlign.center,
                                      style: regular700.copyWith(fontSize: 16, color: AppColor.subFontColor),
                                    ),
                                  ),
                                ),],),
                              ),
                              const SizedBox(height: 20,),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
