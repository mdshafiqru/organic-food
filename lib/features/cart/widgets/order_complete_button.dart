import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/checkout_controller.dart';

class OrderCompleteButton extends StatefulWidget {
  const OrderCompleteButton({
    super.key,
  });

  @override
  State<OrderCompleteButton> createState() => _OrderCompleteButtonState();
}

class _OrderCompleteButtonState extends State<OrderCompleteButton> {
  final _checkoutKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _checkoutKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.w),
              labelText: "প্রাপকের নাম",
              labelStyle: TextStyle(fontSize: 14.sp),
            ),
            controller: _nameController,
            onChanged: (value) {
              Get.find<CheckoutController>().receiverName = value;
            },
            validator: RequiredValidator(errorText: "প্রাপকের নাম দিতে হবে"),
          ),
          SizedBox(height: 10.w),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.w),
              labelText: "মোবাইল নাম্বার",
              labelStyle: TextStyle(fontSize: 14.sp),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            keyboardType: TextInputType.number,
            controller: _phoneController,
            onChanged: (value) {
              Get.find<CheckoutController>().phone = value;
            },
            validator: MultiValidator([
              RequiredValidator(errorText: "মোবাইল নাম্বার দিতে হবে"),
              MinLengthValidator(11, errorText: "মোবাইল নাম্বার ১১ সংখ্যার হতে হবে"),
            ]),
          ),
          SizedBox(height: 20.w),
          Obx(() {
            final controller = Get.find<CheckoutController>();
            bool loading = controller.creatingOrder.value;
            num grandTotal = controller.getGrandTotal;

            String addressId = controller.selectedAddress.value.id ?? "";

            return CustomButton(
              text: "কমপ্লিট অর্ডার${addressId.isNotEmpty ? " ( ৳${AppHelper.getNumberFormated(grandTotal)} )" : ""}",
              onPressed: () {
                if (_checkoutKey.currentState != null) {
                  if (_checkoutKey.currentState!.validate()) {
                    controller.createOrder();
                  }
                }
              },
              loading: loading,
            );
          }),
        ],
      ),
    );
  }
}
