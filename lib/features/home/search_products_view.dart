import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../models/product.dart';
import '../../widgets/loader.dart';
import '../../widgets/unfocus_ontap.dart';
import '../cart/widgets/cart_icon.dart';
import '../dashboard/controllers/dashboard_controller.dart';
import 'widgets/product_card.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  final _searchController = TextEditingController();

  Timer? _debounceTimer;

  void debouncing({required Function() fn, int waitForMs = 800}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }

  _onSearchChange() {
    debouncing(fn: () {
      Get.find<DashboardController>().searchProduct(_searchController.text.trim());
    });
    if (_searchController.text.trim().isEmpty) {
      Get.find<DashboardController>().productsBySearch.clear();
    }
  }

  @override
  void initState() {
    _searchController.addListener(_onSearchChange);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    Get.find<DashboardController>().productsBySearch.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
          centerTitle: true,
          backgroundColor: AppColors.appbarColor,
          elevation: 1,
          title: TextFormField(
            controller: _searchController,
            autofocus: true,
            style: TextStyle(color: AppColors.textWhite, fontSize: 15.sp, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              // filled: true,

              border: InputBorder.none,
              hintText: 'সার্চ করুন',
              hintStyle: const TextStyle(color: AppColors.textWhite),
              suffixIcon: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.close,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ),
          actions: const [CartIcon()],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Obx(() {
              final products = Get.find<DashboardController>().productsBySearch;
              bool loading = Get.find<DashboardController>().searchingProduct.value;
              return loading
                  ? const Loader()
                  : Wrap(
                      children: List.generate(products.length, (index) {
                        final Product product = products[index];
                        return ProductCard(product: product);
                      }),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
