import 'dart:convert';

import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../constants/app_strings.dart';
import '../../../models/address.dart';
import '../../../models/data_result.dart';
import '../../../models/division.dart';
import '../../../models/response_status.dart';
import '../repository/address_repo.dart';
import 'checkout_controller.dart';

class AddressController extends GetxController {
  var divisions = <Division>[].obs;
  var loadingDivisions = false.obs;

  var addresses = <Address>[].obs;
  var loadingAddresses = false.obs;

  var deletingAddress = false.obs;
  var creatingAddress = false.obs;

  var deletingIndex = 0.obs;

  var selectedDivisionId = "";
  var selectedDivision = Division();

  String newDistrictName = "";
  String newThanaName = "";
  String newLocation = "";
  String phone = "";

  createAddress() async {
    if (selectedDivisionId.isEmpty || selectedDivision.id == null) {
      return AppHelper.showToast(message: "একটি বিভাগ সিলেক্ট করুন");
    }
    if (!creatingAddress.value) {
      creatingAddress.value = true;

      final body = jsonEncode({
        "divisionId": selectedDivisionId,
        "district": newDistrictName,
        "thana": newThanaName,
        "location": newLocation,
      });

      final result = await AddressRepo.createAddress(body);

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          getAddresses();
          creatingAddress.value = false;
          AppHelper.showToast(message: status.message ?? "");
          Get.back();
        } else {
          creatingAddress.value = false;
          AppHelper.throwError(error: status.message ?? "");
        }
      } else {
        creatingAddress.value = false;
        AppHelper.throwError(error: result.error ?? "");
      }
    }
  }

  getDivisions() async {
    final DataResult dataResult = await AddressRepo.getDivisions();

    if (dataResult.error == null) {
      final result = dataResult.data != null ? dataResult.data as List<Division> : <Division>[];
      divisions.clear();
      //
      for (var item in result) {
        divisions.add(item);
      }
    } else if (dataResult.error == AppString.noInternetConnection) {
      AppHelper.throwError(error: AppString.noInternetConnection);
    }
  }

  getAddresses() async {
    final DataResult dataResult = await AddressRepo.getAddresses();

    if (dataResult.error == null) {
      final result = dataResult.data != null ? dataResult.data as List<Address> : <Address>[];
      addresses.clear();
      for (var item in result) {
        addresses.add(item);
      }
    } else if (dataResult.error == AppString.noInternetConnection) {
      AppHelper.throwError(error: AppString.noInternetConnection);
    }
  }

  deleteAddress({required Address address, required int index}) async {
    if (!deletingAddress.value) {
      deletingAddress.value = true;
      deletingIndex.value = index;

      final result = await AddressRepo.deleteAddress(address.id ?? "");

      if (result.error == null) {
        final status = result.data != null ? result.data as ResponseStatus : ResponseStatus();

        bool success = status.success ?? false;

        if (success) {
          addresses.removeAt(index);

          final selectedAddress = Get.find<CheckoutController>().selectedAddress.value;

          if (selectedAddress == address) {
            Get.find<CheckoutController>().isAddressSelected.value = false;
            Get.find<CheckoutController>().selectedAddress.value = Address();
          }

          deletingAddress.value = false;
          AppHelper.showToast(message: "ঠিকানাটি ডিলিট করা হয়েছে");
        } else {
          deletingAddress.value = false;
          AppHelper.throwError(error: status.message ?? "");
        }
      } else {
        deletingAddress.value = false;
        AppHelper.throwError(error: result.error ?? "");
      }
    }
  }

  @override
  void onInit() {
    getAddresses();
    getDivisions();
    super.onInit();
  }
}
