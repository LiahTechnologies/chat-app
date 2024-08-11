import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:njadia/src/features/authentication/presentation/pages/authentication.dart';
import 'package:njadia/src/features/create_group/presentation/blocs/group-bloc.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-bloc.dart';
import 'package:njadia/src/utils/naviagtion.dart';
import 'package:njadia/src/utils/theme/theme_bloc.dart';
import 'package:njadia/src/utils/theme/themes.dart';
import 'package:path_provider/path_provider.dart';

import 'src/features/approve-tojoin-group/presentation/bloc/approval-bloc.dart';
import 'src/features/authentication/dependencies_injection.dart';
import 'src/features/direct message/data/model/user-profile-model.dart';
import 'src/features/direct message/presentation/bloc/chat_list_bloc.dart';
import 'src/features/direct message/presentation/bloc/private-socket-bloc.dart';
import 'src/features/group_chat/data/model/group_chat_model.dart';
import 'src/features/group_chat/data/model/group_list_model.dart';
import 'src/features/group_chat/presentation/bloc/group-socket-bloc.dart';
import 'src/features/group_chat/presentation/bloc/group_list_bloc.dart';
import 'src/features/payment/presentation/bloc/group-bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
/// ------- For Docs and Updates Check ------
/// ------------------README.md--------------

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  setUpLocator();


  if (kIsWeb) {

    
} else {
   
   final appDocumentDirectory = await getApplicationDocumentsDirectory();
  
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter<GroupChatModel>(GroupChatModelAdapter());
  Hive.registerAdapter<GroupModel>(GroupModelAdapter());
  Hive.registerAdapter<UserProfileModel>(UserProfileModelAdapter());
}
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
              BlocProvider(create: (_) =>  locator<AuthBloc>()),
              BlocProvider(create: (_) =>  locator<ThemeBloc>()),
              BlocProvider(create: (_) =>  locator<GroupListBloc>()),
              BlocProvider(create: (_) =>  locator<PrivateSocketBloc>()),
              BlocProvider(create: (_) =>  locator<ChatListBloc>()),
              BlocProvider(create: (_) =>  locator<GroupBloc>()),
              BlocProvider(create: (_) =>  locator<SocketBloc>()),
              BlocProvider(create: (_) =>  locator<SearchGroupBloc>()),
              BlocProvider(create: (_) =>  locator<GroupMemberBloc>()),
              BlocProvider(create: (_) =>  locator<ApprovalBloc>()),
  
            
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
