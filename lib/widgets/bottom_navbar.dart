import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_helper.dart';
import '../features/auth/views/signin_view.dart';
import '../features/dashboard/controllers/dashboard_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.whiteColor, width: 1.5.w),
        ),
      ),
      child: Obx(() {
        final controller = Get.find<DashboardController>();
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 25.sp),
              label: "হোম",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 25.sp),
              label: "অর্ডার",
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            if (index == 1) {
              if (AppHelper.isLoggedIn) {
                Get.find<DashboardController>().selectedIndex.value = index;
              } else {
                Get.to(() => const SigninView(), transition: Transition.zoom);
              }
            } else {
              Get.find<DashboardController>().selectedIndex.value = index;
            }
          },
          backgroundColor: AppColors.navbarColor,
          selectedItemColor: AppColors.whiteColor,
          unselectedIconTheme: const IconThemeData(color: AppColors.navbarButtonColor),
          unselectedItemColor: AppColors.navbarButtonColor,
        );
      }),
    );
  }
}
