import 'package:flutter/material.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/api_endpoints.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_helper.dart';
import '../../models/product.dart';
import '../../widgets/custom_button.dart';
import '../auth/views/signin_view.dart';
import '../cart/controllers/cart_controller.dart';
import '../cart/widgets/cart_icon.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    String image = product.image ?? "";
    String imageUrl = image == '' ? '' : ApiEndPoints.rootUrl + image;
    return Scaffold(
      appBar: AppHelper.commonAppbar(
        "পণ্যের বিস্তারিত তথ্য",
        actions: [
          const CartIcon(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              Expanded(
                child: ListView(
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
                        width: double.infinity,
                        height: 200.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              imageUrl,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      product.name ?? "",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGreenColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.size ?? "",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          "৳${AppHelper.getNumberFormated(product.price ?? 0)}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.textGreenColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      "সংক্ষিপ্ত বিবরণ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textGreenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.shortDesc ?? "",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      "বিস্তারিত বিবরণ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textGreenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.longDesc ?? "",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textColor2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.w),
                  ],
                ),
              ),
              CustomButton(
                  text: "কার্টে যোগ করুন",
                  onPressed: () {
                    if (AppHelper.isLoggedIn) {
                      Get.find<CartController>().addToCart(product, msg: 'কার্টে যোগ হয়েছে');
                    } else {
                      Get.to(() => const SigninView(), transition: Transition.zoom);
                    }
                  },
                  loading: false),
              SizedBox(height: 20.w),
            ],
          ),
        ),
      ),
    );
  }
}
