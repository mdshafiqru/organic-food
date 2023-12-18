import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../models/product.dart';
import '../controllers/cart_controller.dart';
import '../controllers/checkout_controller.dart';

class CheckoutDetailsCard extends StatelessWidget {
  const CheckoutDetailsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        child: Column(
          children: [
            Obx(() {
              final cartItems = Get.find<CartController>().cartItems;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(cartItems.length, (index) {
                  final item = cartItems[index];

                  int qty = item.qty ?? 0;
                  double price = item.product?.price ?? 0;
                  double total = qty * price;

                  final Product product = item.product ?? Product();
                  final String image = product.image ?? "";
                  final String imageUrl = image.isNotEmpty ? ApiEndPoints.rootUrl + image : "";

                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final imageProvider = Image.network(imageUrl).image;
                            showImageViewer(
                              context,
                              imageProvider,
                              doubleTapZoomable: true,
                            );
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? "",
                                style: TextStyle(fontSize: 15.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: 10.w),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$qty X ${AppHelper.getNumberFormated(price)}",
                                    style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                                  ),
                                  Text(
                                    "${AppHelper.getNumberFormated(total)}",
                                    style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  num amount = Get.find<CartController>().getTotalPrice;
                  final charge = Get.find<CheckoutController>().getDeliveryCharge;
                  num grandTotal = Get.find<CheckoutController>().getGrandTotal;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment,
                      children: [
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "মোট",
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            Text(
                              "${AppHelper.getNumberFormated(amount)}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: charge == null ? AppColors.textGreenColor : AppColors.textColor1,
                                fontWeight: charge == null ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        if (charge != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ডেলিভারি চার্জ ",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                "${AppHelper.getNumberFormated(charge)}",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        const Divider(),
                        if (charge != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "সর্বোমোটঃ ",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                "৳ ${AppHelper.getNumberFormated(grandTotal)}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textGreenColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
