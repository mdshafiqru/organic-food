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
import '../controllers/signup_controller.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _signupController = Get.put(SignupController());

  final _signupKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusOnTap(
      child: Scaffold(
        appBar: AppHelper.commonAppbar("রেজিস্ট্রেশন"),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Form(
              key: _signupKey,
              child: ListView(
                children: [
                  Text(
                    "রেজিস্ট্রেশন করার জন্য নিচের ফর্মটি পূরন করুন",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.textGreenColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "নাম",
                      ),
                      controller: _nameController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "নাম দিতে হবে"),
                        MinLengthValidator(3, errorText: "নাম কমপক্ষে ৩ সংখ্যার হতে হবে"),
                      ]),
                      onChanged: (value) {
                        Get.find<SignupController>().name = value;
                      },
                    ),
                  ),
                  SizedBox(height: 5.w),
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: "মোবাইল নাম্বার দিতে হবে"),
                        MinLengthValidator(11, errorText: "মোবাইল নাম্বার ১১ সংখ্যার হতে হবে"),
                      ]),
                      onChanged: (value) {
                        Get.find<SignupController>().phone = value;
                      },
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: "পাসওয়ার্ড দিতে হবে"),
                        MinLengthValidator(6, errorText: "পাসওয়ার্ড কমপক্ষে ৬ সংখ্যার হতে হবে"),
                      ]),
                      onChanged: (value) {
                        Get.find<SignupController>().password = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Obx(() {
                    bool loading = Get.find<SignupController>().checking.value;
                    return CustomButton(
                      text: "সাবমিট",
                      onPressed: () {
                        if (_signupKey.currentState != null) {
                          if (_signupKey.currentState!.validate()) {
                            Get.find<SignupController>().signUp();
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
                      Get.back();
                    },
                    child: Text(
                      "একাউন্ট থাকলে লগিন করুন",
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
