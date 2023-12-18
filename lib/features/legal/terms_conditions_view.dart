import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_helper.dart';
import '../dashboard/controllers/dashboard_controller.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("শর্ত সমূহ"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Obx(() {
            final data = Get.find<DashboardController>().appInfo.value.terms ?? "";
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
