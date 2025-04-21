import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/shared/widgets/textfields/custom_field.dart';
import 'package:niklaar/presentation/controllers/sign_up_controller.dart';

class Password extends StatefulWidget {
  final SignUpController? controller;

  const Password({super.key, this.controller});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller?.passwordFormKey,
      child: Column(
        children: [
          verticalSpace(20),
          TextInputField(
            controller: widget.controller?.passwordController,
            hintText: 'Enter Password',
            label: 'Create Password',
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              onPressed:
                  () => setState(() => isPasswordVisible = !isPasswordVisible),
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            inputType: TextInputType.visiblePassword,
            onChanged: (_) => widget.controller?.validatePassword(),
          ),
          TextInputField(
            controller: widget.controller?.confirmPasswordController,
            hintText: 'Confirm Password',
            label: 'Confirm Password',
            obscureText: !isConfirmPasswordVisible,
            suffixIcon: IconButton(
              onPressed:
                  () => setState(
                    () => isConfirmPasswordVisible = !isConfirmPasswordVisible,
                  ),
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
            inputType: TextInputType.visiblePassword,
            onChanged: (_) => widget.controller?.validatePassword(),
          ),
        ],
      ),
    );
  }
}
