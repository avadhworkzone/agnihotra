import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/feedback_screen/user_feedback_screen.dart';
import 'package:sunrise_app/viewModel/help_controller.dart';


class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
 HelpScreenController helpScreenController = Get.find<HelpScreenController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetUtils.backgroundImages,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: CircleAvatar(
                    backgroundColor: ColorUtils.white,
                    radius: 23.r,
                    child: IconButton(
                      onPressed: () {
                       Get.back();
                      },
                      icon: const Icon(
                        AssetUtils.backArrowIcon,
                        color: ColorUtils.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.h),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h,),
                          CustomText(
                            StringUtils.feedbackOptionTxt,
                            color: ColorUtils.greyColor,
                            fontSize: 15.sp,
                          ),
                          SizedBox(height: 20.h,),
                          CustomBtn(
                            height: 50.h,
                            onTap: () {

                              },
                            title: StringUtils.shareFeedbackTxt,
                            bgColor: ColorUtils.borderColor,
                            textColor: ColorUtils.black,
                          ),
                          SizedBox(height: 20.h,),
                          CustomBtn(
                            height: 50.h,
                            onTap: () {

                            },
                            title: StringUtils.shareBotherationTxt,
                            bgColor: ColorUtils.borderColor,
                            textColor: ColorUtils.black,
                          ),
                          SizedBox(height: 30.h,),
                          CommonTextField(
                            hintText: 'Full Name',
                            textEditController: helpScreenController.fullNameController,
                          ),
                          SizedBox(height: 30.h,),
                          CommonTextField(
                            hintText: 'Your Message',
                            textEditController: helpScreenController.yourMessageController,
                          ),
                          SizedBox(height: 40.h,),
                          Padding(
                            padding:EdgeInsets.symmetric(horizontal: 20.w),
                            child: CustomBtn(
                                onTap: () {
                                  Get.to(UserFeedBackScreen(
                                    fullName: helpScreenController.fullNameController.text.trim(),
                                    yourMessage: helpScreenController.yourMessageController.text.trim(),
                                   ),
                                  );
                                },
                              height: 50.h,
                              gradient: const LinearGradient(
                                colors: [
                                  ColorUtils.gridentColor1,
                                  ColorUtils.gridentColor2,
                                ],
                                begin: AlignmentDirectional.topEnd,
                                end: AlignmentDirectional.bottomEnd,
                              ),
                                title: StringUtils.sendBtnTxt,

                            ),
                          ),
                          SizedBox(height: 30.h,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
