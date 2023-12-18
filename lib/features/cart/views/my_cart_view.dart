import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pure_foods/widgets/custom_button.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../controllers/cart_controller.dart';
import '../widgets/cart_icon.dart';
import '../widgets/cart_item_card.dart';
import 'checkout_view.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({super.key});

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar(
        "কার্ট",
        actions: const [
          CartIcon(isCartView: true),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                int itemCount = Get.find<CartController>().cartItems.length;
                return itemCount > 0 ? _itemList() : _noItemText();
              }),
              _checkoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _itemList() {
    return Expanded(
      child: Obx(() {
        final cartItems = Get.find<CartController>().cartItems;
        return ListView(
          children: List.generate(cartItems.length, (index) {
            final item = cartItems[index];

            return CartItemCard(cartItem: item, index: index);
          }),
        );
      }),
    );
  }

  Obx _checkoutButton() {
    return Obx(() {
      int itemCount = Get.find<CartController>().cartItems.length;
      return itemCount > 0
          ? Padding(
              padding: EdgeInsets.only(
                top: 5.w,
                bottom: 10.w,
              ),
              child: Column(
                children: [
                  Text(
                    "সর্বমোটঃ ৳ ${AppHelper.getNumberFormated(Get.find<CartController>().getTotalPrice)}/-",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.textGreenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomButton(
                    text: "চেকআউট",
                    onPressed: () {
                      Get.to(() => const CheckoutView(), transition: Transition.rightToLeft);
                    },
                    loading: false,
                  ),
                ],
              ),
            )
          : Container();
    });
  }

  Column _noItemText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.w),
        Text(
          "কার্টে কোনো পণ্য নেই",
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("শপিং চালিয়ে যান"),
        ),
      ],
    );
  }
}
