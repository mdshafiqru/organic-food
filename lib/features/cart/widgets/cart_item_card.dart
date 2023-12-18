import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../models/cart_item.dart';
import '../../../models/product.dart';
import '../controllers/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.index,
  });

  final CartItem cartItem;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final Product product = cartItem.product ?? Product();
    final String image = product.image ?? "";
    final String imageUrl = image.isNotEmpty ? ApiEndPoints.rootUrl + image : "";

    double price = product.price ?? 0;
    int qty = cartItem.qty ?? 0;

    double total = price * qty;

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                width: 80.w,
                height: 80.w,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "দামঃ ৳${AppHelper.getNumberFormated(price)}",
                            style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor),
                          ),
                          Text(
                            "মোটঃ ৳${AppHelper.getNumberFormated(total)}",
                            style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor),
                          ),
                        ],
                      ),
                      Card(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.selectedCartIndex.value = index;
                                controller.removeItemFromCart(
                                  cartItem: cartItem,
                                  oldCartItem: cartItem,
                                  index: index,
                                  productId: product.id ?? "",
                                );
                              },
                              icon: Obx(
                                () {
                                  bool removing = Get.find<CartController>().removingFromCart.value;
                                  int cartIndex = Get.find<CartController>().selectedCartIndex.value;
                                  return removing
                                      ? cartIndex == index
                                          ? SizedBox(
                                              height: 13.w,
                                              width: 13.w,
                                              child: LoadingIndicator(
                                                indicatorType: Indicator.ballSpinFadeLoader,
                                                colors: const [AppColors.kBaseColor],
                                                strokeWidth: 5.w,
                                              ),
                                            )
                                          : const Icon(Icons.remove)
                                      : const Icon(Icons.remove);
                                },
                              ),
                            ),
                            Text(
                              '$qty',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.selectedCartIndex.value = index;
                                controller.addToCart(product, msg: 'কার্ট আপডেট হয়েছে');
                              },
                              icon: Obx(() {
                                int cartIndex = controller.selectedCartIndex.value;
                                return controller.addingToCart.value
                                    ? index == cartIndex
                                        ? SizedBox(
                                            width: 13.w,
                                            height: 13.w,
                                            child: LoadingIndicator(
                                              indicatorType: Indicator.ballSpinFadeLoader,
                                              colors: const [AppColors.kBaseColor],
                                              strokeWidth: 5.w,
                                            ),
                                          )
                                        : const Icon(Icons.add)
                                    : const Icon(Icons.add);
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
