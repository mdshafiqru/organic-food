import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../models/product_category.dart';
import '../products_by_category_view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => ProductsByCategoryView(category: category));
        },
        child: Text(
          category.name ?? "",
          style: TextStyle(fontSize: 15.sp),
        ),
      ),
    );
  }
}
