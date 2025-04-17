import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/shared/widgets/textfields/custom_field.dart';
import 'package:niklaar/presentation/controllers/sign_up_controller.dart';

class Username extends StatelessWidget {
  final SignUpController? controller;

  const Username({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller?.usernameFormKey,
      child: Column(
        children: [
          verticalSpace(20),
          TextInputField(
            controller: controller?.usernameController,
            hintText: 'Enter username',
            label: 'Choose a username',
            onChanged: (_) => controller?.validateUsername(),
          ),
        ],
      ),
    );
  }
}
