// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_helper.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/unfocus_ontap.dart';
import '../controllers/signin_controller.dart';
import 'signup_view.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final _signinController = Get.put(SigninController());

  final _signinKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppHelper.commonAppbar("লগিন"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Form(
              key: _signinKey,
              child: ListView(
                children: [
                  Text(
                    "অ্যাপে লগিন করুন",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.textGreenColor,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "মোবাইল নাম্বার",
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      onChanged: (value) {
                        Get.find<SigninController>().phone = value;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: "মোবাইল নাম্বার দিতে হবে"),
                        MinLengthValidator(11, errorText: "মোবাইল নাম্বার ১১ সংখ্যার হতে হবে"),
                      ]),
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "পাসওয়ার্ড",
                      ),
                      controller: _passwordController,
                      onChanged: (value) {
                        Get.find<SigninController>().password = value;
                      },
                      validator: MultiValidator([
                        RequiredValidator(errorText: "পাসওয়ার্ড দিতে হবে"),
                        MinLengthValidator(6, errorText: "পাসওয়ার্ড কমপক্ষে ৬ সংখ্যার হতে হবে"),
                      ]),
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Obx(() {
                    final loading = Get.find<SigninController>().checking.value;
                    return CustomButton(
                      text: "সাবমিট",
                      onPressed: () {
                        if (_signinKey.currentState != null) {
                          if (_signinKey.currentState!.validate()) {
                            Get.find<SigninController>().signIn();
                            AppHelper.hideKeyboard(context);
                          }
                        }
                      },
                      loading: loading,
                    );
                  }),
                  SizedBox(height: 20.w),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignupView());
                    },
                    child: Text(
                      "একাউন্ট না থাকলে রেজিস্ট্রেশন করুন",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
