import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:xyz/screens/login/login_screen.dart';
import 'package:xyz/utils/toast/toast.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/config/config_controller.dart';
import '../../controllers/register account/register_account_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../../widgets/custom_button/cutsomButton.dart';
import '../../widgets/text_field/customTextField.dart';
import '../connect_NFT/connect_NFT_screen.dart';
import '../tab screen/tab screen.dart';

class RegisterAccountScreen extends StatefulWidget {
  final int memberId;
  const RegisterAccountScreen({required this.memberId});

  @override
  _RegisterAccountScreenState createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> {
  final registerAccountController = Get.put(RegisterAccountController());
  final _formKey = GlobalKey<FormState>();
  double fixedSpace = 17.0;

    @override
  void initState() {
      registerAccountController.nameTEC.clear();
      registerAccountController.emailTEC.clear();
      registerAccountController.phoneTEC.clear();
      print("----member id--${widget.memberId}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Form(
        key: _formKey,
        child: Stack(
          alignment:  Alignment.center,
          // alignment: const Alignment(-0.3, 0.7),
          children: [
            backgroundThemeWidget(sideLayerImagePath: ImagePath.sideLayerCropped),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(ImagePath.arrow_back_field),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: 450,
                      width: Get.width,
                      // alignment: Alignment.center,
                      // color: Colors.pink,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            authScreensLogo(),
                            const SizedBox(height: 80,),
                            Text("Register to the 1%",style: regular700.copyWith(fontSize: 32,),),
                            const SizedBox(height: 24,),
                            CustomTextField(
                              controller: registerAccountController.nameTEC,
                              nameValidator: true,
                              validationMessage: "Please enter full name",
                              inputType: TextInputType.text,
                              hintText: "Full Name",
                              limit: [],
                              capitalization: TextCapitalization.none,
                            ),
                            SizedBox(
                              height: fixedSpace,
                            ),
                            CustomTextField(
                              controller: registerAccountController.emailTEC,
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
                            CustomTextField(
                              controller: registerAccountController.phoneTEC,
                              phoneValidator: true,
                              validationMessage: "Please enter valid Phone",
                              inputType: TextInputType.phone,
                              hintText: "Phone Number",
                              limit: [],
                              capitalization: TextCapitalization.none,
                            ),
                            // SizedBox(
                            //   height: fixedSpace,
                            // ),
                            // CustomTextField(
                            //   controller: registerAccountController.tokenTEC,
                            //   tokenValidator: true,
                            //   validationMessage: "Please enter Token number",
                            //   inputType: TextInputType.text,
                            //   hintText: "Enter Token Number",
                            //   limit: [],
                            //   capitalization: TextCapitalization.none,
                            // ),
                            SizedBox(
                              height: fixedSpace,
                            ),
                            CustomButton(
                              text: 'Register',
                              onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("---Register---");
                                   registerAccountController.registerAccount(memberId: widget.memberId);
                                  }
                              },
                            ),
                            SizedBox(
                              height: fixedSpace/2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: loginSignUpBottomRow(title: "Already registered ?",buttonName: "Login",onTap: (){
                                Get.back();
                                Get.back();
                              }),
                            ),
                            const SizedBox(height: 10,),
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
