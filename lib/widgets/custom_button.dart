import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor,
    this.textColor,
    required this.loading,
    this.height,
    this.width,
    this.fontSize,
    this.loaderSize,
    this.imagePath,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? buttonColor, textColor;
  final String? imagePath;
  final bool loading;
  final double? height, width, fontSize, loaderSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
      height: height ?? 40.w,
      minWidth: width ?? double.maxFinite,
      color: buttonColor ?? AppColors.kButtonColor,
      onPressed: onPressed,
      child: imagePath == null
          ? loading
              ? SizedBox(
                  height: loaderSize ?? 32.w,
                  width: loaderSize ?? 32.w,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    colors: const [Color(0xFFffffff)],
                    strokeWidth: 5.w,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(fontSize: fontSize ?? 15.sp, color: textColor ?? AppColors.kButtonTextColor),
                )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath!,
                  width: 35.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 20.w),
                loading
                    ? SizedBox(
                        height: loaderSize ?? 32.w,
                        width: loaderSize ?? 32.w,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballSpinFadeLoader,
                          colors: const [Color(0xFFffffff)],
                          strokeWidth: 5.w,
                        ),
                      )
                    : Text(
                        text,
                        style: TextStyle(fontSize: fontSize ?? 15.sp, color: textColor ?? AppColors.kButtonTextColor),
                      )
              ],
            ),
    );
  }
}
