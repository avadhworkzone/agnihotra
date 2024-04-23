import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocalAssets extends StatelessWidget {
  const LocalAssets(
      {Key? key,
        required this.imagePath,
        this.height,
        this.width,
        this.imgColor,
        this.scaleSize, this.fit})
      : super(key: key);
  final String imagePath;
  final BoxFit? fit;
  final double? height, width, scaleSize;
  final Color? imgColor;
  @override
  Widget build(BuildContext context) {
    return imagePath.split('.').last != 'svg'
        ? Image.asset(
      imagePath,
      height: height,
      width: width,

      fit: fit,
      scale: scaleSize,
      color: imgColor,
    )
        : SvgPicture.asset(
      imagePath,
      height: height,
      width: width,
      color: imgColor,
    );
  }
}

