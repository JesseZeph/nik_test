import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/shared/widgets/textfields/custom_field.dart';
import 'package:niklaar/presentation/controllers/sign_up_controller.dart';

class BasicInfo extends StatelessWidget {
  final SignUpController? controller;

  const BasicInfo({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller?.basicInfoFormKey,
      child: Column(
        children: [
          verticalSpace(20),
          TextInputField(
            controller: controller?.lastNameController,
            hintText: 'Stephen',
            label: 'Last Name',
            onChanged: (_) => controller?.validateBasicInfo(),
          ),
          TextInputField(
            controller: controller?.firstNameController,
            hintText: 'Reign',
            label: 'First Name',
            onChanged: (_) => controller?.validateBasicInfo(),
          ),
          TextInputField(
            controller: controller?.emailController,
            hintText: 'stephen@gmail.com',
            label: 'Email Address',
            inputType: TextInputType.emailAddress,
            onChanged: (_) => controller?.validateBasicInfo(),
          ),
          TextInputField(
            controller: controller?.phoneController,
            hintText: '23456789000',
            label: 'Phone Number',
            inputType: TextInputType.phone,
            onChanged: (_) => controller?.validateBasicInfo(),
          ),
        ],
      ),
    );
  }
}
