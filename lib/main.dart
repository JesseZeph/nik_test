import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/routes/app_router.dart';
import 'package:niklaar/core/theme/theme.dart';
import 'package:niklaar/presentation/viewmodels/auth/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          MediaQuery.of(context).size.width > 600
              ? const Size(768, 1024)
              : const Size(375, 812),
      builder: (context, child) {
        return Portal(
          child: MaterialApp.router(
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            debugShowCheckedModeBanner: false,
            title: 'Niklaar',
            theme: lightTheme,
            routerConfig: _appRouter.config(),
          ),
        );
      },
    );
  }
}
