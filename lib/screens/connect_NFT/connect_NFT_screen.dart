import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:xyz/utils/loading_dialog/loading_dialog.dart';

import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../controllers/config/config_controller.dart';
import '../../controllers/connect_to_NFT/connect_to_NFT_controller.dart';
import '../../widgets/custom_button/cutsomButton.dart';
import '../../widgets/text_field/customTextField.dart';
import '../register_account/register_account_screen.dart';

class ConnectNftScreen extends StatefulWidget {
  const ConnectNftScreen({Key? key}) : super(key: key);

  @override
  _ConnectNftScreenState createState() => _ConnectNftScreenState();
}

class _ConnectNftScreenState extends State<ConnectNftScreen> {
  final connectToNftController = Get.put(ConnectToNftController());
  final _formKey = GlobalKey<FormState>();

      @override
  void initState() {
        connectToNftController.tokenNumberTEC.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
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
                    child: Align(
                     alignment: Alignment.center, child: Container(
                        // height: 170,
                        width: Get.width,
                        // color: Colors.pink,
                        child: Column(
                          children: [
                            authScreensLogo(),
                            const SizedBox(height: 80,),
                            CustomTextField(
                              controller: connectToNftController.tokenNumberTEC,
                              tokenValidator: true ,
                              validationMessage: "Please enter Token number",
                              inputType: TextInputType.text,
                              hintText: "Enter Token Number",
                              limit: [],
                              capitalization: TextCapitalization.none,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                              text: 'Connect NFT',
                              onTap: () {
                                // Get.to(const RegisterAccountScreen());
                                  if (_formKey.currentState!.validate()) {
                                    print("---Connect NFT---");
                                    connectToNftController.connectToNftVerification();
                                    // Get.to(const RegisterAccountScreen());
                                  }
                              },
                            ),
                            const SizedBox(height: 16,),
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

Widget authScreensLogo(){
  return Container(
    margin: const EdgeInsets.only(top: 65),
    height: 100,
    width: 115,
    child: Image.asset(ImagePath.logo),
  );
}

Widget backgroundThemeWidget({required String sideLayerImagePath}) {
  return Stack(
    children: [
      // Align(
      //   alignment: Alignment.topCenter,
      //   child: SafeArea(
      //     child: Container(
      //       margin: const EdgeInsets.only(top: 65),
      //       height: 100,
      //       width: 115,
      //       child: Image.asset(ImagePath.logo),
      //     ),
      //   ),
      // ),
      Align(
        alignment: Alignment.topRight,
        child: SizedBox(height: Get.height / 1.8, child: Image.asset(sideLayerImagePath, fit: BoxFit.cover)),
      ),
      Align(
        alignment: Alignment.bottomLeft,
        child:
            SizedBox(height: Get.height / 4.87, child: Image.asset(ImagePath.bottomLayer, fit: BoxFit.cover)),
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     mainAxisSize: MainAxisSize.max,
      //     children: [
      //       Align(
      //         alignment: Alignment.topRight,
      //         child: SizedBox(
      //             height: Get.height / 1.8, child: Image.asset(ImagePath.sideLayerCropped, fit: BoxFit.cover)),
      //       ),
      //       Align(
      //         alignment: Alignment.bottomLeft,
      //         child: SizedBox(
      //             height: Get.height / 4.87, child: Image.asset(ImagePath.bottomLayer, fit: BoxFit.cover)),
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}
