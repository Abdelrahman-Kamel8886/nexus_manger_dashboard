import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/flavor/flavor.dart';
import 'core/router/app_router.dart';


void main() {
  // Flavor is automatically detected from --dart-define=FLAVOR=value
  // See README.md for instructions on how to run/build with different flavors
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = flavorConfig;

    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // Web Full HD design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: config.appTitle,
          theme: config.themeData,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
