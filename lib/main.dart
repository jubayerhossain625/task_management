import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common/bindings/initial_bindings.dart';
import 'core/ConnectionStatusListener.dart';
import 'core/routes/pages.dart';
import 'core/routes/routes.dart';
import 'http_certificate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(const MyApp());
  initNoInternetListener();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: 'Task Management System',
            theme: ThemeData(
              colorScheme: const ColorScheme(
                  brightness: Brightness.light,
                  primary: Color(0xFFDDAF7E),
                  onPrimary: Color(0xFFDDAF7E),
                  secondary: Colors.black,
                  onSecondary: Colors.black,
                  error: Colors.red,
                  onError: Colors.red,
                  surface: Colors.white,
                  onSurface: Colors.grey),
              scaffoldBackgroundColor: const Color(0xFFF7F7F7),
              textTheme: GoogleFonts.montserratTextTheme(),
            ),
            useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            debugShowCheckedModeBanner: false,
            initialBinding: InitialBindings(),
            getPages: Pages.pages,
            home: child,
            navigatorKey: Get.key,
            initialRoute: Routes.splashScreen,
            builder: (context, child) {
              // child = EasyLoading.init()(context, child);
              // child = DevicePreview.appBuilder(context, child);
              child = FToastBuilder()(context, child);
              return child;
            });
      },
      child: Pages.splashScreen,
    );
  }
}
