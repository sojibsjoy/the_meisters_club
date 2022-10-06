import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/screens/login/otp_screen.dart';
import 'package:xyz/screens/register_account/register_account_screen.dart';
import 'package:xyz/widgets/common_widgets/common_widgets.dart';
import 'package:xyz/widgets/gradient_text/gradient_text.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/login/login_controller.dart';
import '../../widgets/custom_button/cutsomButton.dart';
import '../../widgets/text_field/customTextField.dart';
import '../connect_NFT/connect_NFT_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    child: Container(
                      // height: 280,
                      width: Get.width,
                      // alignment: Alignment.center,
                      // color: Colors.pink,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            authScreensLogo(),
                            const SizedBox(height: 80,),
                            Text("Login",
                                style: regular700.copyWith(
                                  fontSize: 32,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Verify your OTP PIN",
                              style: regular400.copyWith(fontSize: 16, color: AppColor.subFontColor),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomTextField(
                              controller: loginController.emailTEC,
                              emailValidator: true,
                              validationMessage: "Please enter valid email",
                              inputType: TextInputType.text,
                              hintText: "Email Address",
                              limit: [],
                              capitalization: TextCapitalization.none,
                            ),
                            SizedBox(
                              height: fixedSpace,
                            ),
                            CustomButton(
                              text: 'Send OTP',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  debugPrint("---Send OTP---");
                                  loginController.loginSendOtpToEmail();
                                }
                              },
                            ),
                            SizedBox(
                              height: fixedSpace / 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: loginSignUpBottomRow(
                                  title: "don't have an account?",
                                  buttonName: "Register",
                                  onTap: () {
                                    Get.to(const ConnectNftScreen());
                                  }),
                            ),
                            const SizedBox(height: 5,),
                          ],
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
