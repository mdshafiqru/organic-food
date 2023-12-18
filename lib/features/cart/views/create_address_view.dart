import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../constants/app_helper.dart';
import '../../../models/division.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/unfocus_ontap.dart';
import '../controllers/address_controller.dart';

class CreateAddressView extends StatefulWidget {
  const CreateAddressView({super.key});

  @override
  State<CreateAddressView> createState() => _CreateAddressViewState();
}

class _CreateAddressViewState extends State<CreateAddressView> {
  final _creatAddressKey = GlobalKey<FormState>();

  final _districtController = TextEditingController();
  final _thanaController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _districtController.dispose();
    _thanaController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHelper.commonAppbar("নতুন ঠিকানা যুক্ত করুন"),
      body: UnfocusOnTap(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
            child: Form(
              key: _creatAddressKey,
              child: ListView(
                children: [
                  SizedBox(height: 10.w),
                  _divisions(),
                  SizedBox(height: 10.w),
                  _district(),
                  SizedBox(height: 10.w),
                  _thana(),
                  SizedBox(height: 10.w),
                  _area(),
                  SizedBox(height: 20.w),
                  _submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Obx _submitButton() {
    return Obx(() {
      final loading = Get.find<AddressController>().creatingAddress.value;
      return CustomButton(
        text: "সাবমিট",
        onPressed: () {
          if (_creatAddressKey.currentState != null) {
            if (_creatAddressKey.currentState!.validate()) {
              Get.find<AddressController>().createAddress();
            }
          }
        },
        loading: loading,
      );
    });
  }

  TextFormField _area() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: "এলাকা",
        labelStyle: TextStyle(fontSize: 14.sp),
        hintText: "বাসা নং / এলাকার ঠিকানা",
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
      ),
      controller: _locationController,
      onChanged: (value) {
        Get.find<AddressController>().newLocation = value;
      },
      validator: RequiredValidator(errorText: "এলাকার ঠিকানা দিতে হবে"),
    );
  }

  TextFormField _thana() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: "থানা",
        labelStyle: TextStyle(fontSize: 14.sp),
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
      ),
      controller: _thanaController,
      onChanged: (value) {
        Get.find<AddressController>().newThanaName = value;
      },
      validator: RequiredValidator(errorText: "থানার নাম দিতে হবে"),
    );
  }

  TextFormField _district() {
    return TextFormField(
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: "জেলা",
        labelStyle: TextStyle(fontSize: 14.sp),
        border: const OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12.w),
      ),
      controller: _districtController,
      onChanged: (value) {
        Get.find<AddressController>().newDistrictName = value;
      },
      validator: RequiredValidator(errorText: "জেলার নাম দিতে হবে"),
    );
  }

  Obx _divisions() {
    return Obx(() {
      var divisions = Get.find<AddressController>().divisions;

      var names = [];

      for (var item in divisions) {
        names.add(item.name ?? "");
      }

      return DropdownSearch(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              // border: const OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12.w),
              hintText: "সার্চ করুন",
            ),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(fontSize: 14.sp),
          dropdownSearchDecoration: InputDecoration(
            labelText: 'বিভাগ',
            labelStyle: TextStyle(fontSize: 14.sp),
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.all(12.w),
          ),
        ),
        items: names,
        selectedItem: names.first,
        onChanged: (name) {
          final controller = Get.find<AddressController>();
          String selectedId = "";
          Division division = Division();

          for (var item in divisions) {
            if (item.name == name) {
              //
              selectedId = item.id ?? "";
              division = item;

              break;
            }
          }
          if (selectedId.isNotEmpty) {
            controller.selectedDivisionId = selectedId;
            controller.selectedDivision = division;
          } else {
            controller.selectedDivisionId = selectedId;
            controller.selectedDivision = Division()..id = "";
          }
        },
      );
    });
  }
}
