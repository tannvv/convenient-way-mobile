import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tien_duong/app/bindings/initial_binding.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/modules/home/views/home_view.dart';
import 'package:tien_duong/app/routes/app_pages.dart';

Key keyApp = const Key('GetMaterialApp');

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        builder: ((context, child) => GetMaterialApp(
              title: 'Tiện đường',
              initialBinding: InitialBinding(),
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return Overlay(
                  initialEntries: [
                    OverlayEntry(
                        builder: (context) => LoaderOverlay(
                            child: child ?? const Scaffold(body: HomeView()))),
                  ],
                );
              },
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                scaffoldBackgroundColor: AppColors.primary100,
                colorScheme: const ColorScheme(
                  primary: AppColors.primary400,
                  secondary: AppColors.secondary400,
                  surface: AppColors.surface,
                  background: AppColors.background,
                  error: AppColors.error,
                  onPrimary: AppColors.onPrimary,
                  onSecondary: AppColors.onSecondary,
                  onSurface: AppColors.onSurface,
                  onBackground: AppColors.onBackground,
                  onError: AppColors.onError,
                  brightness: Brightness.light,
                ),
                focusColor: AppColors.orange,
              ),
              enableLog: true,
              key: keyApp,
            )));
  }
}
