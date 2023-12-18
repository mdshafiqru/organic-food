import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../constants/status.dart';
import '../../../widgets/loader.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import 'order_details_view.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    Get.find<DashboardController>().getAllOrders();
    super.initState();
  }

  Future<void> _refreshPage() async {
    if (_refreshKey.currentState != null) {
      _refreshKey.currentState!.show(atTop: false);
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        Get.find<DashboardController>().getAllOrders();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("অর্ডার সমূহ"),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshKey,
          onRefresh: _refreshPage,
          child: Obx(() {
            final dashboardController = Get.find<DashboardController>();
            final orders = dashboardController.allOrders;
            bool loading = dashboardController.loadingOrders.value;
            return loading
                ? const Loader()
                : orders.isEmpty
                    ? Center(
                        child: Text(
                          "এখন পর্যন্ত কোনো অর্ডার করা হয় নি।",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textColor1,
                          ),
                        ),
                      )
                    : ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                // headingRowColor: MaterialStateColor.resolveWith((states) => AppColors.kBaseColor),
                                headingRowHeight: 40.h,
                                headingTextStyle: const TextStyle(textBaseline: TextBaseline.ideographic),
                                showBottomBorder: true,
                                columnSpacing: 20.0.sp,
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      "#SL",
                                      style: TextStyle(fontSize: 15.0.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Invoice No",
                                      style: TextStyle(fontSize: 15.0.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Amount",
                                      style: TextStyle(fontSize: 15.0.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Date",
                                      style: TextStyle(fontSize: 15.0.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Status",
                                      style: TextStyle(fontSize: 15.0.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      "Action",
                                      style: TextStyle(fontSize: 15.0.sp, color: AppColors.textGreenColor, fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ],
                                rows: orders.map(
                                  ((order) {
                                    int index = orders.indexOf(order);
                                    String createOn = AppHelper.getCustomDate(order.createdAt ?? '');

                                    Color statusColor = Colors.black;

                                    switch (order.status) {
                                      case Status.pending:
                                        statusColor = Colors.deepPurple;
                                        break;

                                      case Status.accepted:
                                        statusColor = Colors.blue;
                                        break;

                                      case Status.rejected:
                                        statusColor = Colors.red;
                                        break;

                                      case Status.shipped:
                                        statusColor = Colors.teal;
                                        break;

                                      case Status.delivered:
                                        statusColor = Colors.green;
                                        break;

                                      case Status.cancelled:
                                        statusColor = Colors.red;

                                        break;

                                      default:
                                    }

                                    return DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          Text(
                                            '${index + 1}',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '# ${order.invoiceId ?? ""}',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                          onTap: () {
                                            AppHelper.copyToClipboard(text: order.invoiceId ?? "");
                                          },
                                        ),
                                        DataCell(
                                          Text(
                                            '৳ ${AppHelper.getNumberFormated(order.grandTotal ?? 0)}',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            createOn,
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '${order.status}',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          IconButton(
                                            onPressed: () {
                                              Get.to(() => OrderDetailsView(order: order, statusColor: statusColor));
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye,
                                              color: AppColors.textGreenColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
          }),
        ),
      ),
    );
  }
}
