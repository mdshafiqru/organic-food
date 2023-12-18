import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/address.dart';
import '../controllers/address_controller.dart';
import '../views/create_address_view.dart';
import 'address_card.dart';

class CheckoutAddressList extends StatelessWidget {
  const CheckoutAddressList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ঠিকানা সমূহ",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textGreenColor,
          ),
        ),
        Obx(() {
          final controller = Get.find<AddressController>();
          final addresses = controller.addresses;
          return addresses.isNotEmpty
              ? Column(
                  children: List.generate(addresses.length, (index) {
                    final Address address = addresses[index];
                    return AddressCard(address: address, index: index);
                  }),
                )
              : Text(
                  "কোনো ঠিকানা পাওয়া যায় নি",
                  style: TextStyle(fontSize: 14.sp),
                );
        }),
        SizedBox(height: 10.w),
        ElevatedButton(
          onPressed: () {
            Get.to(() => const CreateAddressView(), transition: Transition.zoom);
          },
          child: const Text("একটি নতুন ঠিকানা যুক্ত করুন"),
        ),
      ],
    );
  }
}
