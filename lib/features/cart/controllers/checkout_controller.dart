import 'dart:convert';

import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../models/address.dart';
import '../../../models/response_status.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../repository/checkout_repo.dart';
import 'cart_controller.dart';

class CheckoutController extends GetxController {
  var isAddressSelected = false.obs;
  var creatingOrder = false.obs;

  var selectedAddressIndex = 0.obs;

  var selectedAddress = Address().obs;

  var phone = "";
  var receiverName = "";

  createOrder() async {
    String addressId = selectedAddress.value.id ?? "";

    if (addressId.isEmpty) {
      return AppHelper.showToast(message: "একটি ঠিকানা সিলেক্ট করুন");
    }
    //
    if (!creatingOrder.value) {
      creatingOrder.value = true;

      final body = jsonEncode({
        "addressId": addressId,
        "phone": phone,
        "receiverName": receiverName,
      });

      final result = await CheckoutRepo.createOrder(body);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          creatingOrder.value = false;
          AppHelper.showToast(message: status.message ?? "");
          Get.offAll(() => const DashboardView());
        } else {
          creatingOrder.value = false;
          AppHelper.throwError(error: status.message ?? "");
        }
      } else {
        creatingOrder.value = false;
        AppHelper.throwError(error: result.error ?? "");
      }
    }
  }

  num get getGrandTotal {
    num total = Get.find<CartController>().getTotalPrice;
    double deliverCharge = selectedAddress.value.division?.deliveryCharge ?? 0;
    return total + deliverCharge;
  }

  get getDeliveryCharge => selectedAddress.value.division?.deliveryCharge;
}
