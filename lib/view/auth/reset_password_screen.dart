import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_back_arrow.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/view/auth/widget/reset_password_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

    body:  Stack(
          alignment: Alignment.bottomCenter,
          children : [

            ///bg Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetUtils.loginBackgroundImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w,top: 8.h),
                child: const Align(
                    alignment: Alignment.topLeft,
                    child: CommonBackArrow()),
              ),
            ),

            /// App logo
            Positioned(
              left: 125.w,
              top: 90.h,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [

                      BoxShadow(
                        color: ColorUtils.black00.withOpacity(0.18),
                        offset: const Offset(0, 20),
                        blurRadius: 40.r,
                      ),

                    ]),
                child: LocalAssets(
                  imagePath: AssetUtils.bgRemoveAppLogo,
                  height: 136.h,
                  width: 136.h,

                ),
              ),
            ),

             ResetPasswordField(),
          ],
        )

    );
  }
}
