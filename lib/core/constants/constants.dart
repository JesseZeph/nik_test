import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:niklaar/core/constants/app_strings.dart';
import 'package:niklaar/core/services/network/api_services.dart';
import 'package:niklaar/core/services/network/app_dio.dart';
import 'package:niklaar/core/services/storage/secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niklaar/presentation/views/onboarding/splashscreen.dart';

final getIt = GetIt.instance;

verticalSpace(double height) {
  return SizedBox(height: height.h);
}

horizontalSpace(double width) {
  return SizedBox(width: width.w);
}

initDependencies() async {
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(const FlutterSecureStorage()),
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(AppDio.fromConfig()),
  );

  await GoogleFonts.pendingFonts([
    GoogleFonts.manrope(),
    GoogleFonts.inter(),
  ]).timeout(const Duration(seconds: 10), onTimeout: () => []);
}

logMessage(String messageSource, String message, {StackTrace? stackTrace}) {
  log(
    "=========> Message from $messageSource ====================> \n \n =========> Message: $message",
  );
  if (stackTrace != null) {
    debugPrintStack(stackTrace: stackTrace);
  }
}

Future<Widget> fetchInitialHomePage() async {
  final firstScreen = await getIt<SecureStorageService>().readData(
    AppStrings.firstScreen,
  );
  Widget homePage = switch (firstScreen) {
    _ => const SplashScreen(),
  };

  return homePage;
}

double height = 812.h;
double width = 375.w;
