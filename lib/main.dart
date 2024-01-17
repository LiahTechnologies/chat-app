import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:njadia/src/common/constants/style/appAsset.dart';
import 'package:njadia/src/features/authentication/screens/authentication.dart';
import 'package:njadia/src/utils/theme/themes.dart';

import 'src/routing/approutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/utils/theme/themeController.dart';

/// ------- For Docs and Updates Check ------
/// ------------------README.md--------------

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// await FaceCamera.initialize();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            // home: ChatScreen(),
            // themeMode: themeController.theme,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

          

            supportedLocales: [
              const Locale('en'),
              const Locale('el'),
              const Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
              const Locale.fromSubtags(
                  languageCode: 'zh',
                  scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
            ],
            localizationsDelegates: [
              CountryLocalizations.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            getPages: AppPages.appPagas,
            initialRoute: AppRoutes.SPLASHSCREEN,
            //
          );
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 7), () {
      Get.offAll(Authenentication());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 320.h,
                left: 50.w,
                child: Image.asset(AppImages.LOADING_ICON)),
            Positioned(
                bottom: 20,
                left: 140.w,
                child: SvgPicture.asset("assets/images/loading.svg"))
          ],
        ),
      ),
    );
  }
}
