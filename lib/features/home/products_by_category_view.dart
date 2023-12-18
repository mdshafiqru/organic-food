import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/product_category.dart';
import '../../../widgets/loader.dart';
import '../../constants/app_helper.dart';
import '../../models/product.dart';
import '../cart/widgets/cart_icon.dart';
import '../dashboard/controllers/dashboard_controller.dart';
import 'widgets/product_card.dart';

class ProductsByCategoryView extends StatefulWidget {
  const ProductsByCategoryView({
    super.key,
    required this.category,
  });

  final ProductCategory category;

  @override
  State<ProductsByCategoryView> createState() => _ProductsByCategoryViewState();
}

class _ProductsByCategoryViewState extends State<ProductsByCategoryView> {
  @override
  void initState() {
    Get.find<DashboardController>().getProductsByCategory(widget.category.id ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar(
        widget.category.name ?? "",
        actions: [
          const CartIcon(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
          child: ListView(
            children: [
              Obx(() {
                final products = Get.find<DashboardController>().productsByCategory;
                bool loading = Get.find<DashboardController>().loadingProductsByCategory.value;
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
          ),
        ),
      ),
    );
  }

  // AppBar _appbar() {
  //   return AppBar(
  //     iconTheme: const IconThemeData(color: AppColors.whiteColor),
  //     centerTitle: true,
  //     backgroundColor: AppColors.appbarColor,
  //     elevation: 1,
  //     title: Text(
  //       widget.category.name ?? "",
  //       style: TextStyle(
  //         color: AppColors.whiteColor,
  //         fontSize: 18.sp,
  //       ),
  //     ),
  //   );
  // }
}
