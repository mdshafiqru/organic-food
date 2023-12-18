import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/product_category.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import 'category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ক্যাটাগরি সমূহ",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textGreenColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.w),
        Obx(() {
          final categories = Get.find<DashboardController>().categories;
          return Wrap(
            children: List.generate(categories.length, (index) {
              final ProductCategory category = categories[index];
              return CategoryCard(category: category);
            }),
          );
        }),
      ],
    );
  }
}
