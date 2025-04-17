import 'package:flutter/material.dart';
import 'package:niklaar/presentation/viewmodels/auth/auth_provider.dart';

class SignUpController {
  SignUpController({required AuthProvider authProvider})
    : _authProvider = authProvider;

  final AuthProvider _authProvider;
  final PageController pageController = PageController();

  final ValueNotifier<int> currentStepIndex = ValueNotifier(0);

  final ValueNotifier<bool> isBasicInfoValid = ValueNotifier(false);
  final ValueNotifier<bool> isUsernameValid = ValueNotifier(false);
  final ValueNotifier<bool> isPasswordValid = ValueNotifier(false);

  final basicInfoFormKey = GlobalKey<FormState>();
  final usernameFormKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralController = TextEditingController();

  bool get isAllStepsCompleted =>
      isBasicInfoValid.value && isUsernameValid.value && isPasswordValid.value;

  void validateBasicInfo() {
    if (lastNameController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        _isValidEmail(emailController.text) &&
        phoneController.text.isNotEmpty) {
      isBasicInfoValid.value = true;
    } else {
      isBasicInfoValid.value = false;
    }
  }

  void validateUsername() {
    if (usernameController.text.isNotEmpty &&
        usernameController.text.length >= 3) {
      isUsernameValid.value = true;
    } else {
      isUsernameValid.value = false;
    }
  }

  void validatePassword() {
    if (passwordController.text.isNotEmpty &&
        passwordController.text.length >= 6 &&
        confirmPasswordController.text == passwordController.text) {
      isPasswordValid.value = true;
    } else {
      isPasswordValid.value = false;
    }
  }

  void goToNextStep() {
    switch (currentStepIndex.value) {
      case 0:
        if (isBasicInfoValid.value) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
      case 1:
        if (isUsernameValid.value) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
      case 2:
        if (isPasswordValid.value) {
          final currentFormState = passwordFormKey.currentState;
          _apiSignUp(currentFormState);
        }
        break;
    }
  }

  late Function(bool) _onSignUpComplete;

  void setNavigationCallback(Function(bool) callback) {
    _onSignUpComplete = callback;
  }

  Future<void> _apiSignUp(FormState? formState) async {
    final result = await _authProvider.signUp(
      formState: formState,
      passwordConfirmation: confirmPasswordController.text,
      password: passwordController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      lastName: lastNameController.text,
      firstName: firstNameController.text,
      username: usernameController.text,
      referral: referralController.text,
    );

    if (result) {
      _onSignUpComplete(true);
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void onPageChanged(int page) {
    currentStepIndex.value = page;
  }

  void dispose() {
    pageController.dispose();
    currentStepIndex.dispose();
    isBasicInfoValid.dispose();
    isUsernameValid.dispose();
    isPasswordValid.dispose();

    lastNameController.dispose();
    firstNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
