import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_helper.dart';
import '../features/dashboard/controllers/dashboard_controller.dart';
import '../features/legal/about_us_view.dart';
import '../features/legal/contact_us_view.dart';
import '../features/legal/privacy_policy_view.dart';
import '../features/legal/terms_conditions_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.w),
              ListTile(
                leading: const Icon(Icons.home, color: AppColors.textColor1),
                title: Text(
                  "হোম",
                  style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                ),
                onTap: () {
                  Get.back();
                  Get.find<DashboardController>().selectedIndex.value = 0;
                },
              ),
              _divider(),
              ListTile(
                leading: const Icon(Icons.question_mark_rounded, color: AppColors.textColor1),
                title: Text(
                  "আমাদের সম্পর্কে",
                  style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => const AboutUsView());
                },
              ),
              _divider(),
              ListTile(
                leading: const Icon(Icons.email_outlined, color: AppColors.textColor1),
                title: Text(
                  "যোগাযোগ",
                  style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => const ContactUsView());
                },
              ),
              _divider(),
              ListTile(
                leading: const Icon(Icons.my_library_books_rounded, color: AppColors.textColor1),
                title: Text(
                  "শর্ত সমূহ",
                  style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => const TermsConditionsView());
                },
              ),
              _divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.textColor1),
                title: Text(
                  "প্রাইভেসি পলিসি",
                  style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => const PrivacyPolicyView());
                },
              ),
              if (AppHelper.isLoggedIn) _divider(),
              if (AppHelper.isLoggedIn)
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.textColor1),
                  title: Text(
                    "লগ আউট",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                  ),
                  onTap: () {
                    Get.back();
                    AppHelper.confirmLogout(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Divider _divider() {
    return Divider(
      height: 1.w,
      color: AppColors.textColor4,
      indent: 15.w,
    );
  }
}
