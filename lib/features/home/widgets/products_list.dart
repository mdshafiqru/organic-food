import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/product.dart';
import '../../../widgets/loader.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import 'product_card.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "পণ্য সমূহ",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textGreenColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.w),
        Obx(() {
          final products = Get.find<DashboardController>().products;
          bool loading = Get.find<DashboardController>().loadingProducts.value;
          return loading
              ? const Loader()
              : Wrap(
                  children: List.generate(products.length, (index) {
                    final Product product = products[index];
                    return ProductCard(product: product);
                  }),
                );
        }),
      ],
    );
  }
}
