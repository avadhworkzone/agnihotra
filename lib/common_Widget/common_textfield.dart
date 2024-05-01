import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/color_utils.dart';

typedef OnChangeString = void Function(String value);

class CommonTextField extends StatelessWidget {
  final TextEditingController? textEditController;
  final String? title;
  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? keyBoardType;
  final String? regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final String? labelText;
  final String? preFixIconPath;
  final int? maxLine;
  final TextStyle? labelStyle;
  final Widget? sIcon;
  final Widget? pIcon;
  final bool? obscureValue;
  final bool? underLineBorder;
  final bool? showLabel;
  final InputBorder? border;
  final OnChangeString? onChange;
  final Color? titleColor;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextAlignVertical? textAlignVertical;
  final InputBorder? focusedBorder;
  final TextStyle? hintStyle;


  const CommonTextField({
    super.key,
    this.regularExpression,
    this.inputFormatters,
    this.validator,
    this.title,
    this.textEditController,
    this.isValidate = true,
    this.keyBoardType,
    this.inputLength,
    this.readOnly = false,
    this.underLineBorder = false,
    this.showLabel = false,
    this.hintText,
    this.validationMessage,
    this.maxLine,
    this.sIcon,
    this.pIcon,
    this.preFixIconPath,
    this.onChange,
    this.initialValue = '',
    this.obscureValue,
    this.titleColor = ColorUtils.black1F, this.textAlignVertical, this.border, this.contentPadding, this.focusedBorder, this.labelText, this.labelStyle, this.hintStyle,
  });

  /// PLEASE IMPORT GET X PACKAGE
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: textEditController,
        // textAlignVertical: textAlignVertical,

        style: const TextStyle(
            color: ColorUtils.black1F,
            fontSize: 15
        ),
        keyboardType: keyBoardType ?? TextInputType.text,
        maxLines: maxLine ?? 1,
        onChanged: onChange,
        validator: validator,
        decoration: InputDecoration(
          focusedBorder: focusedBorder,
          labelText: labelText,
          labelStyle: labelStyle,
          border: border,
          contentPadding: contentPadding ?? EdgeInsets.zero,
          hintText: hintText!.tr,
          hintStyle: hintStyle,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12.sp,
          ),
          prefixIcon: pIcon,
          suffixIcon: sIcon,
          counterText: '',
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
