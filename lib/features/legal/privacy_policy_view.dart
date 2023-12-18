import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_helper.dart';
import '../dashboard/controllers/dashboard_controller.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("প্রাইভেসি পলিসি"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Obx(() {
            final data = Get.find<DashboardController>().appInfo.value.privacy ?? "";
            return HtmlWidget(
              '''
              $data
            ''',
              textStyle: TextStyle(fontSize: 15.w, color: AppColors.textColor1),
              onTapUrl: (url) async {
                if (!await launchUrl(Uri.parse(url))) {
                  throw Exception('Could not launch $url');
                }
                return true;
              },
            );
          }),
        ),
      ),
    );
  }
}
