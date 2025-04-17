import 'package:auto_route/auto_route.dart';
import 'package:niklaar/presentation/views/authentication/select_country.dart';
import 'package:niklaar/presentation/views/authentication/sign_up.dart';
import 'package:niklaar/presentation/views/authentication/verify_email.dart';
import 'package:niklaar/presentation/views/onboarding/onboarding.dart';
import 'package:niklaar/presentation/views/onboarding/splashscreen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page, initial: true, path: '/'),
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),
    AutoRoute(page: SelectCountryRoute.page, path: '/select-country'),
    AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
    AutoRoute(page: VerifyEmailRoute.page, path: '/verify-email'),
  ];
}
