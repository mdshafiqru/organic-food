import 'dart:convert';
import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../features/dashboard/views/dashboard_view.dart';
import '../widgets/custom_button.dart';
import 'app_colors.dart';
import 'app_strings.dart';

class AppHelper {
  AppHelper._();

  static final _storage = GetStorage();
  static const _secureStorage = FlutterSecureStorage();

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }

  static copyToClipboard({required String text}) {
    FlutterClipboard.copy(text).then((value) => showToast(message: "Text Copied"));
  }

  static getTimeAmPm(String date) {
    if (date.isEmpty) {
      return "";
    } else {
      DateTime dateTime = DateTime.parse(date).toLocal();

      String formattedTime = DateFormat.jm().format(dateTime);

      return formattedTime; // Output: 5:10 PM
    }
  }

  static Widget loader() {
    return Center(
      child: SizedBox(
        width: 60.w,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: const [AppColors.kButtonColor],
          strokeWidth: 1.w,
        ),
      ),
    );
  }

  static getNumberFormated(num number) {
    var numberFormater = NumberFormat('#,##,###.##');
    return numberFormater.format(number);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool get isLoggedIn => _storage.read(AppString.isLoggedIn) ?? false;

  static handleError(int statusCode, json) {
    switch (statusCode) {
      case 400:
        return json['message'] ?? "Something went wrong";

      case 401:
        return AppString.unAuthenticated;

      case 403:
        return json['message'];

      case 404:
        return json['message'];

      case 422:
        final errors = json['errors'];
        return errors[errors.keys.elementAt(0)][0];

      case 500:
        return AppString.serverError;

      default:
        return AppString.somethingWentWrong;
    }
  }

  static getCustomDate(String date) {
    if (date.isEmpty) {
      return "";
    }
    DateTime time = DateTime.parse(date).toLocal();
    int month = time.month;
    int day = time.day;
    int year = time.year;
    String newDay = day < 10 ? '0$day' : '$day';
    String newMonth = month < 10 ? '0$month' : '$month';

    String newDate = '$newDay-$newMonth-$year';

    return newDate;
  }

// logout
  static Future<void> logout() async {
    await _storage.erase();

    await _secureStorage.delete(key: AppString.accessToken);
    Get.offAll(() => const DashboardView());
    showSnackBar(message: "Log out successfull");
  }

  static AppBar commonAppbar(String title, {List<Widget>? actions}) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      centerTitle: true,
      backgroundColor: AppColors.appbarColor,
      elevation: 1,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 18.sp,
        ),
      ),
      actions: actions,
    );
  }

  static Future<String> getToken() async {
    String token = await _secureStorage.read(key: AppString.accessToken) ?? "";

    return token;
  }

  static void showSnackBar({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.kBaseColorToLight,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Future.delayed(const Duration(seconds: 1)).then((value) {
      Fluttertoast.cancel();
    });
  }

  static AppBar appbar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(fontSize: 15.sp, color: AppColors.textColor4),
      ),
      centerTitle: true,
      backgroundColor: AppColors.appbarColor,
      iconTheme: const IconThemeData().copyWith(color: AppColors.whiteColor),
    );
  }

  static void showAlert({required String title, required String message, VoidCallback? onTap}) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: AppColors.textColor1, fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 15.sp, color: AppColors.textColor1),
            textAlign: TextAlign.center,
          ),
          actions: [
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                width: 20.w,
                height: 30.w,
                text: "OK",
                onPressed: onTap ?? () => Navigator.of(context).pop(),
                loading: false,
              ),
            ),
          ],
        );
      },
    );
  }

  static void confirmLogout(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout?',
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        content: Text(
          'Are you sure to logout?',
          style: TextStyle(
            fontSize: 13.sp,
          ),
        ),
        actions: [
          MaterialButton(
            color: AppColors.textGreenColor,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          MaterialButton(
            color: AppColors.redColor,
            onPressed: () {
              logout();
            },
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void throwError({required String error, String? message}) {
    switch (error) {
      case AppString.unAuthenticated:
        AppHelper.logout();
        break;

      case AppString.noInternetConnection:
        AppHelper.showToast(message: AppString.noInternetConnection);
        break;

      case AppString.timeOutError:
        AppHelper.showToast(message: AppString.timeOutError);
        break;
      default:
        AppHelper.showToast(message: message ?? error);
    }
  }

  static void showconfirmDialog({required String title, required String text, required VoidCallback onConfirm, required BuildContext context}) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        content: Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
          ),
        ),
        actions: [
          MaterialButton(
            color: AppColors.textGreenColor,
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'না',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          MaterialButton(
            color: AppColors.redColor,
            onPressed: onConfirm,
            child: Text(
              'হ্যা',
              style: TextStyle(fontSize: 13.sp, color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
