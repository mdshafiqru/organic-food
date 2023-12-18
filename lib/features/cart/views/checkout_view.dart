// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../widgets/unfocus_ontap.dart';
import '../controllers/address_controller.dart';
import '../controllers/checkout_controller.dart';
import '../widgets/checkout_address_list.dart';
import '../widgets/checkout_details_card.dart';
import '../widgets/order_complete_button.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _addressController = Get.put(AddressController());
  final _checkoutController = Get.put(CheckoutController());

  final _checkoutKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppHelper.commonAppbar("চেকআউট"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: ListView(
              children: [
                const CheckoutDetailsCard(),
                SizedBox(height: 20.w),
                const CheckoutAddressList(),
                SizedBox(height: 20.w),
                const OrderCompleteButton(),
                SizedBox(height: 10.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
