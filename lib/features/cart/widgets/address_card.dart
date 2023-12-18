import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/address.dart';
import '../controllers/address_controller.dart';
import '../controllers/checkout_controller.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    required this.index,
  });

  final Address address;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CheckoutController>();
    return InkWell(
      onTap: () {
        controller.isAddressSelected.value = true;
        controller.selectedAddressIndex.value = index;
        controller.selectedAddress.value = address;
      },
      child: Dismissible(
        key: Key(address.id ?? ""),
        onDismissed: (direction) {
          Get.find<AddressController>().deleteAddress(address: address, index: index);
        },
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  final selectedIndex = controller.selectedAddressIndex.value;

                  bool selectedThis = selectedIndex == index;

                  bool addressSelected = controller.isAddressSelected.value;

                  return addressSelected
                      ? selectedThis
                          ? const Icon(Icons.check_circle, color: AppColors.textGreenColor)
                          : const Icon(Icons.check_circle_outline)
                      : const Icon(Icons.check_circle_outline);
                }),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.location ?? "",
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.start,
                      ),
                      Wrap(
                        children: [
                          Text(
                            "${address.thana ?? ""}, ${address.district}, ",
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "বিভাগঃ ${address.division?.name ?? ""}",
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
