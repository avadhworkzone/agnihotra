import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/animation/slide_transition_animation.dart';
import 'package:sunrise_app/common_Widget/common_back_arrow.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/help_screen/feedback_screen.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/help_controller.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  HelpScreenController helpScreenController = Get.find<HelpScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(width: 15.w),
                  const CommonBackArrow(),
                  SizedBox(width: 120.w),
                  CustomText(
                    StringUtils.helpTxt,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),

                ],
              ),
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
                          SizedBox(
                            height: 10.h,
                          ),
                          ListTile(
                            onTap: () {
                              helpScreenController.makingPhoneCall();
                              },
                            leading: const Icon(
                              AssetUtils.phoneIcon,
                              color: ColorUtils.orange,
                            ),
                            title:CustomText(
                              StringUtils.callHelpLine,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          ListTile(
                            onTap: () {
                              helpScreenController.sendingMails();
                            },
                            leading: const Icon(
                              AssetUtils.emailIcon,
                              color: ColorUtils.orange,
                            ),
                            title:CustomText(
                              StringUtils.emailSupport,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          ListTile(
                            onTap: () {
                               helpScreenController.sendingWhatsappMsg();
                            },
                            leading: const Icon(
                              AssetUtils.chatIcon,
                              color: ColorUtils.orange,
                            ),
                            title:CustomText(
                              StringUtils.chatSupport,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          ListTile(
                            onTap: () {
                              SlideTransitionAnimation.rightToLeftAnimation(const FeedbackScreen());
                              // Get.to(const FeedbackScreen());
                            },
                            leading: const Icon(
                              AssetUtils.feedBackIcon,
                              color: ColorUtils.orange,
                            ),
                            title:CustomText(
                              StringUtils.feedback,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color: ColorUtils.black1F,
                            ),
                          ),
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
