import 'package:get/get.dart';
import 'package:task_management/features/auth/bindungs/auth_bindings.dart';
import 'package:task_management/features/auth/presentation/login/login_screen.dart';
import 'package:task_management/features/auth/presentation/otp-verify/otp_verify.dart';
import 'package:task_management/features/home/bindings/home_bindings.dart';
import 'package:task_management/features/home/presentation/home_screen.dart';
import 'package:task_management/features/profile/bindings/profile_bindings.dart';
import 'package:task_management/features/profile/edit_profile.dart';
import '../../common/widgets/offline_screen.dart';
import '../../features/auth/presentation/register/regsiter_screen.dart';
import '../../features/splash/bindings/splash_screen_bindings.dart';
import '../../features/splash/presentation/splash_screen_view.dart';
import 'routes.dart';

class Pages {
  // static const splashScreen = SamplePage();
  static const splashScreen = SplashScreenView();

  static final List<GetPage> pages = [
    // offline Screen
    GetPage(
      name: Routes.offlineScreen,
      page: () => const OfflineScreen(),
    ),
    // Splash Route
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreenView(),
      binding: SplashScreenBindings(),
    ),

    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: Routes.otpVerify,
      page: () => const OTPVerify(),
      binding: AuthBindings(),
    ),

    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBindings()
    ),
    GetPage(
      name: Routes.profile,
      page: () => const EditProfileScreen(),
      binding: ProfileBindings()
    ),

  ];
}
