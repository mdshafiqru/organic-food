import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_helper.dart';
import '../dashboard/controllers/dashboard_controller.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("যোগাযোগ"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: ListView(
            children: [
              SizedBox(height: 20.w),
              Text(
                "যেকোনো প্রয়োজনে আমাদের সাথে যোগাযোগের জন্য নিচের ইমেইল মেইল করুন।",
                style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5.w),
              Obx(() {
                String email = Get.find<DashboardController>().appInfo.value.email ?? "";
                return InkWell(
                  onTap: () {
                    AppHelper.copyToClipboard(text: email);
                  },
                  child: Text(
                    email,
                    style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
