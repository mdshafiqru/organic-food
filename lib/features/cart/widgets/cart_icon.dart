// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../auth/views/signin_view.dart';
import '../controllers/cart_controller.dart';
import '../views/my_cart_view.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key, this.isCartView = false}) : super(key: key);

  final bool isCartView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isCartView) {
          if (AppHelper.isLoggedIn) {
            Get.to(() => MyCartView(), transition: Transition.zoom);
          } else {
            Get.to(() => SigninView(), transition: Transition.zoom);
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          children: [
            Icon(Icons.shopping_cart),
            Obx(() {
              bool loggedIn = AppHelper.isLoggedIn;

              int count = Get.find<CartController>().getTotalItemOnCart;

              return loggedIn
                  ? Text(
                      count.toString(),
                      style: TextStyle(color: AppColors.whiteColor, fontSize: 15.sp),
                    )
                  : Container();
            }),
          ],
        ),
      ),
    );
  }
}
