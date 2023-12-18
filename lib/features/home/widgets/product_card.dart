import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../models/product.dart';
import '../../auth/views/signin_view.dart';
import '../../cart/controllers/cart_controller.dart';
import '../product_details_view.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final image = product.image ?? "";

    String imageUrl = image == '' ? '' : ApiEndPoints.rootUrl + image;

    return Padding(
      padding: EdgeInsets.all(4.0.w),
      child: InkWell(
        onTap: () {
          Get.to(() => ProductDetailsView(product: product));
        },
        child: Card(
          elevation: 2.w,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Container(
            width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 0.3.w,
                color: AppColors.kBaseColor.withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _image(imageUrl),
                _details(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _details() {
    return SizedBox(
      width: 150.w,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () {
                if (AppHelper.isLoggedIn) {
                  Get.find<CartController>().addToCart(product, msg: 'কার্টে যোগ হয়েছে');
                } else {
                  Get.to(() => const SigninView(), transition: Transition.zoom);
                }
              },
              icon: Icon(
                Icons.add_shopping_cart,
                color: AppColors.textGreenColor,
                size: 22.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? "",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.kBaseColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.size ?? "",
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  "৳${AppHelper.getNumberFormated(product.price ?? 0)}",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.textGreenColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _image(String image) {
    return Container(
      height: 130.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
