import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:njadia/src/features/authentication/presentation/pages/authentication.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/utils/theme/theme_bloc.dart';
import 'package:njadia/src/utils/theme/themes.dart';

import 'src/features/authentication/dependencies_injection.dart';

/// ------- For Docs and Updates Check ------
/// ------------------README.md--------------

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => locator<AuthBloc>()),
              BlocProvider(create: (_) => locator<ThemeBloc>()),
              BlocProvider(create: (_) => locator<ThemeBloc>())
            ],
            child: BlocBuilder<ThemeBloc, ThemeMode>(builder: (context, state) {
              return MaterialApp(
                // home: ChatScreen(),
                themeMode: state,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,

                supportedLocales: [
                  const Locale('en'),
                  const Locale('el'),
                  const Locale.fromSubtags(
                      languageCode: 'zh',
                      scriptCode:
                          'Hans'), // Generic Simplified Chinese 'zh_Hans'
                  const Locale.fromSubtags(
                      languageCode: 'zh',
                      scriptCode:
                          'Hant'), // Generic traditional Chinese 'zh_Hant'
                ],
                localizationsDelegates: [
                  // CountryLocalizations.delegate,
                  // GlobalMaterialLocalizations.delegate,
                  // GlobalWidgetsLocalizations.delegate,
                  // GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
                // getPages: AppPages.appPagas,
                // initialRoute: AppRoutes.SPLASHSCREEN,
                //
              );
            }),
          );
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  )..repeat(reverse: false);

  late final Animation<double> animation =
      CurvedAnimation(parent: animationController, curve: Curves.linear);

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      
      SplashScreenNavigator(page: Authenentication(), context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    animationController.dispose();
    super.dispose();
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
                child: RotationTransition(
                    turns: animation,
                    child: SvgPicture.asset("assets/images/loading.svg")))
          ],
        ),
      ),
    );
  }
}
