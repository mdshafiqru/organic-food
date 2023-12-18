import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/app_helper.dart';
import '../../../constants/app_strings.dart';
import '../../../models/user.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../repositories/auth_repo.dart';

class SigninController extends GetxController {
  final _storage = GetStorage();
  final _secureStorage = const FlutterSecureStorage();
  String phone = "";
  String password = "";

  var checking = false.obs;

  signIn() async {
    if (!checking.value) {
      checking.value = true;

      String body = jsonEncode({
        "phone": phone,
        "password": password,
      });

      final result = await AuthRepo.signIn(body);

      if (result.error == null) {
        final user = result.data != null ? result.data as User : User();

        await _storage.write(AppString.isLoggedIn, true);
        await _storage.write(AppString.userPhone, user.phone);
        await _secureStorage.write(key: AppString.accessToken, value: user.token);

        checking.value = false;
        AppHelper.showSnackBar(message: "Login Successfull");
        Get.offAll(() => const DashboardView());
      } else if (result.error == AppString.noInternetConnection) {
        checking.value = false;
        AppHelper.showAlert(title: "No Internet", message: result.error ?? "");
      } else {
        checking.value = false;
        AppHelper.showAlert(title: "Opps!", message: result.error ?? "Something went wrong");
      }
    }
  }
}
