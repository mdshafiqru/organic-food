import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../models/order_item.dart';
import '../../../models/product.dart';

class OrderItemDetail extends StatelessWidget {
  const OrderItemDetail({
    super.key,
    required this.item,
  });

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    final Product product = item.product ?? Product();
    final String image = product.image ?? "";
    final String imageUrl = image.isNotEmpty ? ApiEndPoints.rootUrl + image : "";

    return Padding(
      padding: EdgeInsets.all(10.0.w),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                final imageProvider = Image.network(imageUrl).image;
                showImageViewer(
                  context,
                  imageProvider,
                  doubleTapZoomable: true,
                );
              },
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.w),
          Text(
            product.name ?? "",
            style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w500),
          ),
          Text(
            product.size ?? "",
            style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w500),
          ),
          Text(
            "৳ ${AppHelper.getNumberFormated(item.price ?? 0)}",
            style: TextStyle(fontSize: 15.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
