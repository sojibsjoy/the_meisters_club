import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xyz/config/text_style_path_provider/text_style.dart';

import '../../../config/colors_path_provider/colors.dart';
import '../../../controllers/support/support_controller.dart';
import '../../../widgets/common_widgets/common_widgets.dart';
import '../../../widgets/custom_button/cutsomButton.dart';
import '../../../widgets/text_field/customTextField.dart';
import '../../splash/splash_screen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  double fixedSpace = 17.0;
  final supportController = Get.put(SupportController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    supportController.nameTEC.clear();
    supportController.emailTEC.clear();
    supportController.phoneTEC.clear();
    supportController.messageTEC.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.background,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: [
              appBarForMenuScreens(title: "Contact Us"),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  backgroundThemeWidgetSplashScreen(
                      isOtherScreen: true, isSecondVisible: true),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: Get.height - 110.7,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            titleText("We’re Here to Help You", fontSize: 22),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "We always want to hear from you! Let us know how we can best help you and we'll do our very best.",
                              style: regular400.copyWith(
                                  fontSize: 16, color: AppColor.subFontColor),
                            ),
                            const SizedBox(
                              height: 34,
                            ),
                            CustomTextField(
                              controller: supportController.nameTEC,
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
                              controller: supportController.emailTEC,
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
                              controller: supportController.phoneTEC,
                              phoneValidator: true,
                              validationMessage: "Please enter valid Phone",
                              inputType: TextInputType.phone,
                              hintText: "Phone Number",
                              limit: [],
                              capitalization: TextCapitalization.none,
                            ),
                            SizedBox(
                              height: fixedSpace,
                            ),
                            CustomTextField(
                              controller: supportController.messageTEC,
                              textAreaValidator: true,
                              validationMessage: "Please type Message",
                              inputType: TextInputType.multiline,
                              hintText: "Type Message",
                              limit: [],
                              capitalization: TextCapitalization.none,
                            ),
                            SizedBox(
                              height: fixedSpace,
                            ),
                            CustomButton(
                              text: 'Submit',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  print("---Submit---");
                                  supportController.submitContactUs();
                                }
                              },
                            ),
                          ]),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
