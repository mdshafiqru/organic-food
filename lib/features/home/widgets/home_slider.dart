import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/app_colors.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.w,
      child: Obx(() {
        final sliders = Get.find<DashboardController>().sliders;
        return sliders.isNotEmpty
            ? Swiper(
                outer: false,
                itemBuilder: (BuildContext context, int index) {
                  String image = sliders[index].image ?? '';
                  String imageUrl = image == '' ? '' : ApiEndPoints.rootUrl + image;

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.contain),
                      // image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.contain),
                      // color: AppColors.cardColor1,
                    ),
                  );
                },
                pagination: SwiperPagination(
                  margin: EdgeInsets.all(1.0.w),
                  builder: SwiperPagination.dots,
                ),
                itemCount: sliders.length,
                autoplay: true,
                autoplayDelay: 3000,
                duration: 1000,
              )
            : Container(
                height: 180.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.whiteColor,
                ),
                width: double.infinity,
                child: Shimmer.fromColors(
                  baseColor: AppColors.whiteColor,
                  highlightColor: const Color.fromARGB(255, 82, 81, 81),
                  child: ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180.w,
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
