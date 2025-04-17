import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/theme/app_colors.dart' show AppColor;
import 'package:niklaar/presentation/controllers/sign_up_controller.dart';
import 'package:niklaar/presentation/viewmodels/auth/auth_provider.dart';
import 'package:niklaar/shared/widgets/app_loader.dart';
import 'package:niklaar/shared/widgets/app_padding.dart';
import 'package:auto_route/auto_route.dart';
import 'package:niklaar/shared/widgets/buttons/animated_button.dart';
import 'package:niklaar/shared/widgets/buttons/roundedbutton.dart';
import 'package:niklaar/shared/widgets/custom_header.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';
import 'package:niklaar/presentation/views/authentication/steps/basic_info.dart';
import 'package:niklaar/presentation/views/authentication/steps/username.dart';
import 'package:niklaar/presentation/views/authentication/steps/password.dart';
import 'package:niklaar/core/routes/app_router.dart';
import 'package:provider/provider.dart';

import 'components/authsteps.dart';

@RoutePage(name: 'SignUpRoute')
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignUpController(authProvider: AuthProvider());
    _controller.setNavigationCallback(_handleSignUpComplete);
  }

  void _handleSignUpComplete(bool success) {
    if (success) {
      context.router.replace(const VerifyEmailRoute());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLoading = authProvider.state == AuthState.loading;
    return PageLoader(
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: CustomPadding(
            child: Column(
              spacing: 10,
              children: [
                ValueListenableBuilder(
                  valueListenable: _controller.currentStepIndex,
                  builder: (context, currentStep, _) {
                    return CustomAuthHeader(
                      context: context,
                      onTap: () => context.router.maybePop(),
                      widget:
                          currentStep == 2
                              ? Image.asset(
                                'assets/images/nik.png',
                                width: 40.w,
                                height: 40.h,
                              )
                              : null,
                      showImage: currentStep < 2 ? true : false,
                    );
                  },
                ),

                verticalSpace(10),
                NikText(
                  text: 'Let\'s get you started',
                  size: 18,
                  weight: FontWeight.w500,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: NikText(
                    text:
                        'Enter your details and create a password to set up your account',
                    size: 14,
                  ),
                ),

                ValueListenableBuilder(
                  valueListenable: _controller.currentStepIndex,
                  builder: (context, currentStep, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _controller.isBasicInfoValid,
                          builder: (context, isValid, _) {
                            return AuthSteps(
                              text: 'Basic Info',
                              isActive: currentStep == 0 || isValid,
                              showCheckmark: isValid,
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: _controller.isUsernameValid,
                          builder: (context, isValid, _) {
                            return AuthSteps(
                              text: 'Username',
                              isActive: currentStep == 1 || isValid,
                              showCheckmark: isValid,
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: _controller.isPasswordValid,
                          builder: (context, isValid, _) {
                            return AuthSteps(
                              text: 'Password',
                              isActive: currentStep == 2 || isValid,
                              showCheckmark: isValid,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),

                Expanded(
                  child: PageView(
                    controller: _controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: _controller.onPageChanged,
                    children: [
                      BasicInfo(controller: _controller),
                      Username(controller: _controller),
                      Password(controller: _controller),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.05),
                  child: ValueListenableBuilder(
                    valueListenable: _controller.currentStepIndex,
                    builder: (context, currentStep, _) {
                      if (currentStep == 0) {
                        // Basic info step
                        return ValueListenableBuilder(
                          valueListenable: _controller.isBasicInfoValid,
                          builder: (context, isValid, _) {
                            return AnimatedButton(
                              onTap: isValid ? _controller.goToNextStep : null,
                              child: CustomButton(
                                title: 'Continue',
                                color:
                                    isValid
                                        ? AppColor.primary
                                        : AppColor.nikGrey,
                              ),
                            );
                          },
                        );
                      } else if (currentStep == 1) {
                        return ValueListenableBuilder(
                          valueListenable: _controller.isUsernameValid,
                          builder: (context, isValid, _) {
                            return AnimatedButton(
                              onTap: isValid ? _controller.goToNextStep : null,
                              child: CustomButton(
                                title: 'Continue',
                                color:
                                    isValid
                                        ? AppColor.primary
                                        : AppColor.nikGrey,
                              ),
                            );
                          },
                        );
                      } else {
                        return ValueListenableBuilder(
                          valueListenable: _controller.isPasswordValid,
                          builder: (context, isValid, _) {
                            return AnimatedButton(
                              onTap: isValid ? _controller.goToNextStep : null,
                              child: CustomButton(
                                title: 'Create Account',
                                color:
                                    isValid
                                        ? AppColor.primary
                                        : AppColor.nikGrey,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
