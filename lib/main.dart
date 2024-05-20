// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:umash_user/view/screens/splash/splash.dart';
import 'package:get/get.dart';
import 'common/loading.dart';
import 'controller/theme_controller.dart';
import 'helper/get_di.dart' as di;
import 'controller/localization_controller.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/app_constants.dart';
import 'utils/messages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  }
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({required this.languages, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide > 600;
    final bool isLargeTablet = MediaQuery.of(context).size.shortestSide > 800;

    final Size designSize;

    if (isLargeTablet) {
      designSize = const Size(1024, 1366);
    } else if (isTablet) {
      designSize = const Size(768, 1024);
    } else {
      designSize = const Size(411.4, 867.4);
    }

    return ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        fontSizeResolver: (size, util) {
          return size *
              (isTablet
                  ? 1.2
                  : isLargeTablet
                      ? 1.0
                      : util.scaleText);
        },
        builder: (context, child) {
          return GetBuilder<ThemeController>(
            builder: (themeController) {
              return GetBuilder<LocalizationController>(
                builder: (localizeController) {
                  return GetMaterialApp(
                    title: AppConstants.APP_NAME,
                    debugShowCheckedModeBanner: false,
                    theme: themeController.darkTheme
                        ? dark(context: context)
                        : light(context: context),
                    locale: localizeController.locale,
                    translations: Messages(languages: languages),
                    fallbackLocale: Locale(
                      AppConstants.languages[0].languageCode,
                      AppConstants.languages[0].countryCode,
                    ),
                    navigatorObservers: [FlutterSmartDialog.observer],
                    builder: FlutterSmartDialog.init(
                      loadingBuilder: (string) => const Loading(),
                    ),
                    home: const SplashScreen(),
                  );
                },
              );
            },
          );
        });
  }
}
