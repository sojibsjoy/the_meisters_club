import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:xyz/widgets/recommended_login/recommended_login.dart';
import '../../config/colors_path_provider/colors.dart';
import '../../config/image_path_provider/image_path_provider.dart';
import '../../config/text_style_path_provider/text_style.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../controllers/tab/tab_screen_controller.dart';
import '../../widgets/common_widgets/common_widgets.dart';
import '../../widgets/custom_button/cutsomButton.dart';
import '../../widgets/text_field/customTextField.dart';
import '../home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isEditProfile;

  const ProfileScreen({this.isEditProfile = false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final profileController = Get.put(ProfileController());

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() {
    if (Get.find<TabScreenController>().isLogin.value) {
      profileController.getUserDetails();
      profileController.getUserJoinedEvents(showLoader: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: Obx(() {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: firstBgWidget(isSecondItemVisible: false),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: secondBgWidget(isSecondItemVisible: false),
              ),
              Get.find<TabScreenController>().isLogin.value
                  ? SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200 + 45,
                              color: AppColor.background,
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Positioned(
                                    top: -4,
                                    child: SizedBox(
                                      height: 200,
                                      width: Get.width,
                                      child: Image.asset(
                                          ImagePath.profile_cover_image),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            height: 70,
                                            width: Get.width,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 70,
                                                  width: 70,
                                                  margin: const EdgeInsets.only(
                                                      left: 8),
                                                  child: profileWithBorder(
                                                      profileImage: profileController
                                                                  .profileDetailsMap[
                                                              'image'] ??
                                                          ImagePath
                                                              .profileNetImageUnknown,
                                                      radius: 70),
                                                ),
                                                Container(
                                                  height: 48,
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: Get.width - 145,
                                                        // color: AppColor.red,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: Get.width -
                                                                  (widget.isEditProfile
                                                                      ? 180
                                                                      : 145),
                                                              // color: AppColor.green,
                                                              child: titleText(
                                                                  profileController
                                                                              .profileDetailsMap[
                                                                          'name'] ??
                                                                      "",
                                                                  fontSize: 20),
                                                            ),

                                                            /// EDIT NAME
                                                            if (widget
                                                                .isEditProfile)
                                                              editButton(
                                                                  onTap: () {
                                                                Get.dialog(
                                                                    const PopUpProfileUpdate(
                                                                  isName: true,
                                                                ));
                                                              })
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: Get.width - 145,
                                                        child: subTitleText(
                                                            profileController
                                                                        .profileDetailsMap[
                                                                    'email'] ??
                                                                ""),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                // Container(
                                                //   margin: const EdgeInsets.only(
                                                //       right: 8),
                                                //   child:
                                                //       diamondWithColorWidget(),
                                                // ),
                                              ],
                                            ),
                                          ),

                                          ///EDIT Profile Image
                                          if (widget.isEditProfile)
                                            Positioned(
                                              left: 51.5,
                                              child: editRoundedButton(
                                                onTap: () async {
                                                  var image =
                                                      await profileController
                                                          .uploadImageAndGetImageLink();
                                                  if (image != null) {
                                                    profileController
                                                        .updateProfile(
                                                            isProfilePic: true,
                                                            profileImage:
                                                                image);
                                                  }
                                                },
                                              ),
                                            )
                                        ],
                                      )),

                                  /// EDIT (Back Button)
                                  if (widget.isEditProfile)
                                    Positioned(
                                      top: 16,
                                      left: 16,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: SizedBox(
                                          // height: 200,
                                          // width: Get.width,
                                          child: SvgPicture.asset(
                                              ImagePath.arrow_back_field),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: horizontalPadding,
                              child: Row(
                                children: [
                                  Text(
                                    "About ${profileController.profileDetailsMap['name'] ?? ""}",
                                    style: regular700.copyWith(fontSize: 20),
                                  ),
                                  const Spacer(),

                                  /// EDIT About
                                  if (widget.isEditProfile)
                                    editButton(onTap: () {
                                      Get.dialog(const PopUpProfileUpdate(
                                        isAbout: true,
                                      ));
                                    })
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: horizontalPadding,
                              child: Text(
                                profileController
                                        .profileDetailsMap['aboutMember'] ??
                                    "",
                                style: regular400.copyWith(
                                    fontSize: 14, color: AppColor.subFontColor),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: horizontalPadding,
                              child: Text(
                                // "${profileController.profileDetailsMap['name'] ?? " "} Attend events",
                                'My Events',
                                style: regular700.copyWith(fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    profileController.userEventsList.length,
                                itemBuilder: ((context, index) {
                                  return upComingEventsWidget(
                                    eventId: profileController
                                        .userEventsList[index]['eventId'],
                                    image: profileController
                                            .userEventsList[index]
                                        ['eventImagesResponses'][0]['image'],
                                    title: profileController
                                        .userEventsList[index]['eventName'],
                                    locationName: profileController
                                        .userEventsList[index]['location'],
                                    date: profileController
                                        .userEventsList[index]['eventDate'],
                                    isLiked: profileController
                                        .userEventsList[index]['isWished'],
                                    onTap: () {
                                      profileController.userEventsList[index]
                                              ['isWished'] =
                                          !profileController
                                                  .userEventsList[index]
                                              ['isWished'];
                                      profileController.userEventsList
                                          .refresh();
                                      eventDetailsController
                                          .addToWishListEvents(
                                              eventId: profileController
                                                      .userEventsList[index]
                                                  ['eventId']);
                                    },
                                    isFullWidth: true,
                                    isEligble:
                                        profileController.userEventsList[index]
                                                ['isEligble'] ??
                                            false,
                                  );
                                }))
                          ]),
                    )
                  : Center(child: LoginRecommendedWidget(
                      afterCompletion: () {
                        profileController.getUserDetails();
                        profileController.getUserJoinedEvents(
                            showLoader: false);
                      },
                    )),
            ],
          );
        }),
      ),
    );
  }
}

Widget editRoundedButton({required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          ImagePath.profile_photo_update_circle_svg,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 14, child: SvgPicture.asset(ImagePath.edit_icon)),
      ],
    ),
  );
}

Widget editButton({required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SvgPicture.asset(ImagePath.edit_icon),
    ),
  );
}

var horizontalPadding = const EdgeInsets.symmetric(horizontal: 8.0);

Widget profileWithBorder(
    {required String profileImage,
    double radius = 70,
    Color? borderColor /*,bool isListLastImage=false,*/
    }) {
  //1.76
  return SizedBox(
      width: radius,
      height: radius,
      // decoration: BoxDecoration(color:AppColor.red,borderRadius: circularBorder),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: borderColor ?? AppColor.background,
          ),
          CircleAvatar(
            radius: radius - 36.5,
            backgroundImage: NetworkImage(
              profileImage,
            ),
            backgroundColor: AppColor.background,
          ),
        ],
      ));
}

class PopUpProfileUpdate extends StatefulWidget {
  final bool isName;
  final bool isAbout;

  const PopUpProfileUpdate({this.isName = false, this.isAbout = false});

  @override
  State<PopUpProfileUpdate> createState() => _PopUpProfileUpdateState();
}

class _PopUpProfileUpdateState extends State<PopUpProfileUpdate> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background.withOpacity(0.8),
      body: Center(
        child: Form(
            key: _formKey,
            child: Container(
              // height: Get.height,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.accent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.border),
              ),
              // padding: EdgeInsets.all(4),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      decoration: const BoxDecoration(
                        color: AppColor.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // titleText("Update"),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  AppColor.whiteColor.withOpacity(0.1),
                              radius: 15,
                              child: Icon(
                                Icons.clear_rounded,
                                color: AppColor.whiteColor.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.isName)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: profileController.nameTEC,
                          nameValidator: true,
                          validationMessage: "Please enter full name",
                          inputType: TextInputType.text,
                          hintText: "Full Name",
                          limit: const [],
                          capitalization: TextCapitalization.none,
                        ),
                      ),
                    if (widget.isAbout)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextField(
                          controller: profileController.aboutTEC,
                          textAreaValidator: true,
                          validationMessage: "Please enter About",
                          inputType: TextInputType.multiline,
                          hintText: "About",
                          limit: const [],
                          capitalization: TextCapitalization.none,
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        text: 'Update',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            print("---Submit---");
                            Get.back();
                            profileController.updateProfile(
                                isName: widget.isName, isAbout: widget.isAbout);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
