import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/shared/widgets/textfields/custom_field.dart';
import 'package:niklaar/presentation/controllers/sign_up_controller.dart';

class Password extends StatelessWidget {
  final SignUpController? controller;

  const Password({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller?.passwordFormKey,
      child: Column(
        children: [
          verticalSpace(20),
          TextInputField(
            controller: controller?.passwordController,
            hintText: 'Enter Password',
            label: 'Create Password',
            obscureText: true,
            inputType: TextInputType.visiblePassword,
            onChanged: (_) => controller?.validatePassword(),
          ),
          TextInputField(
            controller: controller?.confirmPasswordController,
            hintText: 'Confirm Password',
            label: 'Confirm Password',
            obscureText: true,
            inputType: TextInputType.visiblePassword,
            onChanged: (_) => controller?.validatePassword(),
          ),
        ],
      ),
    );
  }
}
