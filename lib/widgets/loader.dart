import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../constants/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 60.w,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: const [AppColors.kButtonColor],
          strokeWidth: 1.w,
        ),
      ),
    );
  }
}
