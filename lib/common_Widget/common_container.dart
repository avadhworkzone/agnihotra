import 'package:flutter/material.dart';

Container commonContainer({
  AlignmentGeometry? alignment,
  EdgeInsetsGeometry? padding,
  Decoration? decoration,
  double? width,
  double? height,
  EdgeInsetsGeometry? margin,
  Widget? child,
}){
  return Container(
    alignment: alignment,
    padding: padding,
    decoration: decoration,
    width: width,
    height: height,
    margin: margin,
    child: child,
  );
}
