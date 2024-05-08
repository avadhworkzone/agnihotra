import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/view/auth/widget/create_account.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Stack(
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

          /// App logo
          Positioned(
            left: 125.w,
            top: 80.h,
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

           CreateAccount(),
        ],
      ),

    );
  }
}
