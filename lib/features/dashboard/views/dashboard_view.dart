// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/bottom_navbar.dart';
import '../../auth/controllers/profile_controller.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../home/home_view.dart';
import '../../orders/views/my_orders_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _dashboardController = Get.put(DashboardController());
  final _cartController = Get.put(CartController());
  final _profileController = Get.put(ProfileController());

  List<Widget> listWidgets = const [
    HomeView(),
    MyOrdersView(),
  ];

  @override
  Widget build(BuildContext context) {
    // Get.find<CartController>().getCartItems();
    return Scaffold(
      body: WillPopScope(
        onWillPop: _showExitDialog,
        child: Obx(() {
          final controller = Get.find<DashboardController>();
          return SafeArea(
            bottom: false,
            child: listWidgets[controller.selectedIndex.value],
            // child: MyCartView(),
          );
        }),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Future<bool> _showExitDialog() async {
    final controller = Get.find<DashboardController>();
    final selectedIndex = controller.selectedIndex.value;

    if (selectedIndex == 0) {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Exit App?',
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
          content: Text(
            'Do you want to exit this app?',
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
          actions: [
            MaterialButton(
              color: AppColors.textGreenColor,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            MaterialButton(
              color: AppColors.redColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      controller.selectedIndex.value = 0;
      return false;
    }
  }
}
