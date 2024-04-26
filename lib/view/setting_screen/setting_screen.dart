import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SeetingScreenState();
}

class _SeetingScreenState extends State<SettingsScreen> {
  SettingScreenController settingScreenController =
      Get.find<SettingScreenController>();
  GoogleController googleController = Get.find<GoogleController>();
  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      settingScreenController.isScreenOn.value =
          PrefServices.getBool('keepScreenOn');
      if (settingScreenController.isScreenOn.value) {
        KeepScreenOn.turnOn();
      }

      print("PrefServices.getString('selectedAlarmTime') :- ${PrefServices.getString('selectedAlarmTime')}");

    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
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
                          Get.off(SunriseSunetScreen());
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: CustomText(
                                StringUtils.checkTimeTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp,
                                color: ColorUtils.orange,
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                width: 300.w,
                                child: CustomText(
                                  StringUtils.checkDeviceTimeTxt,
                                  color: ColorUtils.black,
                                  maxLines: 5,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.screenOnTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .isScreenOn.value,
                                      onChanged: (value) {
                                        settingScreenController
                                            .isScreenOn.value = value;
                                        PrefServices.setValue(
                                            'keepScreenOn',
                                            settingScreenController
                                                .isScreenOn.value);
                                        if (settingScreenController
                                            .isScreenOn.value) {
                                          KeepScreenOn.turnOn();
                                          print('screen is on');
                                        } else {
                                          KeepScreenOn.turnOff();
                                          print('screen is off');
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomText(
                              StringUtils.screenKeepTxt,
                              color: ColorUtils.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.hoursTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .is24Hours.value,
                                      onChanged: (value) {
                                        // setState(() {
                                        settingScreenController
                                            .toggleTimeFormat(value);
                                        // });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomText(
                              StringUtils.timeTxt,
                              color: ColorUtils.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.meditationTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController.on2.value,
                                      onChanged: (value) {
                                        // setState(() {
                                        settingScreenController.toggle2();
                                        // });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.ringsTxt,
                              color: ColorUtils.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Display CountDown
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.countDownTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .isCountDown.value,
                                      onChanged: (value) {
                                        settingScreenController
                                            .toggleCountDown(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.countDownClockTxt,
                              color: ColorUtils.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Remainder
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.reminderTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  const Spacer(),

                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController.on4.value,
                                      onChanged: (value) async {
                                        settingScreenController.toggle4();

                                        if (settingScreenController.on4.value) {
                                        final TimeOfDay? time =
                                             await showTimePicker(
                                            barrierDismissible: false,
                                            context: context,
                                            initialTime: selectedTime ?? TimeOfDay.now(),
                                            initialEntryMode: entryMode,
                                            orientation: orientation,
                                            builder: (BuildContext context,
                                                Widget? child) {

                                              return Theme(
                                                  data: _buildShrineTheme(),
                                                  child: child!);
                                            },
                                          );

                                          setState((){
                                            selectedTime = time;
                                            print("selectedTime :- ${selectedTime?.format(context)}");
                                            PrefServices.setValue('selectedAlarmTime', selectedTime?.format(context).toString());
                                          });

                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.setReminderTxt,
                              color: ColorUtils.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            if(settingScreenController.on4.value)
                              CustomText(
                                '${StringUtils.ringAlarmTxt.tr} ${selectedTime?.format(context)}',
                                color: ColorUtils.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Reset Button
                            Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 110.w),
                                child: CustomBtn(
                                  height: 45.h,
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorUtils.gridentColor1,
                                      ColorUtils.gridentColor2,
                                    ],
                                    begin: AlignmentDirectional.topEnd,
                                    end: AlignmentDirectional.bottomEnd,
                                  ),
                                  onTap: () async {
                                    resetButtonDialog();
                                  },
                                  title: StringUtils.resetBtnTxt,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10.h,
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
      ),
    );
  }

  ThemeData _buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: shrineBackgroundWhite,
      cardColor: shrineBackgroundWhite,
      buttonTheme: ButtonThemeData(
        colorScheme: _shrineColorScheme,
        textTheme: ButtonTextTheme.normal,
      ),
      primaryIconTheme: _customIconTheme(base.iconTheme),
      textTheme: _buildShrineTextTheme(base.textTheme),
      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
      iconTheme: _customIconTheme(base.iconTheme),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return shrinePink400;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          }
          return null;
        }),
      ),
      colorScheme: _shrineColorScheme.copyWith(error: shrineErrorRed),
    );
  }

  final ColorScheme _shrineColorScheme = ColorScheme(
    primary: const Color(0xFFFD5013).withOpacity(0.8),
    secondary: const Color(0xFFFD5013).withOpacity(0.8),
    surface: shrineSurfaceWhite,
    background: shrineBackgroundWhite,
    error: shrineErrorRed,
    onPrimary: shrineBrown900,
    onSecondary: shrineBrown900,
    onSurface: shrineBrown900,
    onBackground: shrineBrown900,
    onError: shrineSurfaceWhite,
    brightness: Brightness.light,
  );

  static const Color shrinePink400 = Color(0xFFEAA4A4);

  static const Color shrineBrown900 = Color(0xFF442B2D);

  static const Color shrineErrorRed = Color(0xFFC5032B);

  static const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
  static const Color shrineBackgroundWhite = Colors.white;

  static const defaultLetterSpacing = 0.03;

  IconThemeData _customIconTheme(IconThemeData original) {
    return original.copyWith(color: shrineBrown900);
  }

  TextTheme _buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
          bodySmall: base.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: defaultLetterSpacing,
          ),
          labelLarge: base.labelLarge!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: defaultLetterSpacing,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: shrineBrown900,
          bodyColor: shrineBrown900,
        );
  }

  Future resetButtonDialog() {
    return Get.dialog(AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide.none),
      title: Padding(
        padding: EdgeInsets.only(left: 13.w, right: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              StringUtils.alertTxt,
              color: ColorUtils.black00,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
            CustomText(
              StringUtils.resetButtonNotice,
              color: ColorUtils.black00,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// cancel button
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: CustomText(
                    StringUtils.cancleTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),

                /// Proceed
                TextButton(
                  onPressed: () {
                    googleController.clearLocationList();
                    googleController.address.value = '';
                    PrefServices.setValue('currentAddress', '');
                    PrefServices.setValue('countryName', '');
                    PrefServices.setValue('currentLat', 0.0);
                    PrefServices.setValue('currentLong', 0.0).then((value) {
                      Fluttertoast.showToast(msg: StringUtils.resetMsg.tr);
                    });

                    Get.back();
                  },
                  child: CustomText(
                    StringUtils.proceedTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
