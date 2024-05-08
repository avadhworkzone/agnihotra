import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/profile_controller.dart';

List<String> list = <String>[
  StringUtils.selectGenderTxt.tr,
  StringUtils.maleTxt.tr,
  StringUtils.femaleTxt.tr,
  StringUtils.otherTxt.tr
];

class EditProfileField extends StatelessWidget {
  EditProfileField({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final RxString dropdownValue = list.first.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24.h,
        ),

        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            StringUtils.userNameTxt,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: ColorUtils.black1F,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),

        /// UserName Field
        SizedBox(
          height: 45.h,
          child: CommonTextFormField(
            textEditController: profileController.userNameController,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
              borderRadius: BorderRadius.circular(6.r),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            hintText: '',
          ),
        ),

        SizedBox(
          height: 11.h,
        ),

        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            StringUtils.nameTxt,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: ColorUtils.black1F,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),

        /// Name Field
        SizedBox(
          height: 45.h,
          child: CommonTextFormField(
            textEditController: profileController.nameController,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
              borderRadius: BorderRadius.circular(6.r),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            hintText: '',
            showLabel: true,
          ),
        ),

        SizedBox(
          height: 11.h,
        ),

        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            StringUtils.emailAddressTxt,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: ColorUtils.black1F,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),

        /// Email Address Field
        SizedBox(
          height: 45.h,
          child: CommonTextFormField(
            textEditController: profileController.emailController,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(color: ColorUtils.grayD1, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.orange, width: 1.5.w),
              borderRadius: BorderRadius.circular(6.r),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            hintText: '',
            showLabel: true,
          ),
        ),

        SizedBox(
          height: 11.h,
        ),

        Align(
          alignment: Alignment.topLeft,
          child: CustomText(
            StringUtils.genderTxt,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: ColorUtils.black1F,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),

        /// Gender-DropDown

        Container(
          height: 50.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: Colors.transparent, // Set border color
                width: 1.5.w,
              )),
          child: DropdownMenu<String>(
            initialSelection: list.first,
            trailingIcon: const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: ColorUtils.orangeE2,
            ),

            /// font style
            textStyle: TextStyle(
                color: ColorUtils.black13, fontSize: 13.sp, height: 1.h),
            expandedInsets: EdgeInsets.zero,
            onSelected: (String? value) {
              dropdownValue.value = value!;
            },
            dropdownMenuEntries:
            list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(
                value: value,
                label: value,
              );
            }).toList(),
          ),
        ),

        SizedBox(
          height: Get.height / 4.5,
        ),

        /// Update Button
        CustomBtn(
          height: 33.h,
          width: 146.w,
          gradient: const LinearGradient(
            colors: [
              ColorUtils.gridentColor1,
              ColorUtils.gridentColor2,
            ],
            begin: AlignmentDirectional.topEnd,
            end: AlignmentDirectional.bottomEnd,
          ),
          onTap: () {
            // Get.back();
          },
          title: StringUtils.updateBtnTxt,
          fontSize: 12.sp,
        ),
      ],
    );
  }
}
