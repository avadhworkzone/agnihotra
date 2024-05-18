import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';

class UserFeedBackScreen extends StatefulWidget {
  final String fullName;
  final String yourMessage;
  const UserFeedBackScreen({Key? key, required this.fullName, required this.yourMessage,}) : super(key: key);

  @override
  State<UserFeedBackScreen> createState() => _UserFeedBackScreenState();
}

class _UserFeedBackScreenState extends State<UserFeedBackScreen> {
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
            padding:EdgeInsets.only(top: 90.h),
            child: ListView(
              children: [
                Padding(
                  padding:EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r),),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h,),
                          ListTile(
                            title: CustomText(
                              widget.fullName,
                              // color: ColorUtils.black,
                              color: ColorUtils.black1F,
                            ),
                            subtitle: CustomText(
                              widget.yourMessage,
                              // color: ColorUtils.black,
                              color: ColorUtils.black1F,
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
