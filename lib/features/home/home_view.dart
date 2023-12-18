import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../widgets/custom_drawer.dart';
import '../cart/widgets/cart_icon.dart';

import 'search_products_view.dart';
import 'widgets/category_list.dart';
import 'widgets/home_slider.dart';
import 'widgets/products_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: ListView(
            children: [
              SizedBox(height: 2.w),
              const HomeSlider(),
              SizedBox(height: 10.w),
              const CategoryList(),
              SizedBox(height: 10.w),
              const ProductsList(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      centerTitle: true,
      backgroundColor: AppColors.appbarColor,
      elevation: 1,
      title: Text(
        AppString.appName,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18.sp,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => const SearchProductPage());
          },
          child: const Icon(Icons.search),
        ),
        const CartIcon(),
      ],
    );
  }
}
