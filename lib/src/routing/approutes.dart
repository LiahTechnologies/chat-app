import 'package:get/get.dart';

import 'package:njadia/src/features/add%20_people/presentation/view/add_people.dart';
import 'package:njadia/src/features/authentication/screens/login/view/login.dart';
import 'package:njadia/src/features/group_chat/presentation/view/chatpage.dart';
import 'package:njadia/src/features/group_chat/presentation/view/create_group.dart';
import 'package:njadia/src/features/direct%20message/presentation/view/direct-message.dart';
import 'package:njadia/src/features/group_chat/presentation/view/group_category.dart';
import 'package:njadia/src/features/group_chat/presentation/view/search_groups..dart';
import 'package:njadia/src/features/payment/presentation/view/group_home_page.dart';
import 'package:njadia/src/features/payment/presentation/view/menu_page.dart';
import 'package:njadia/src/features/payment/presentation/view/select_group_member.dart';
import 'package:njadia/src/features/payment/presentation/view/send_money.dart';
import 'package:njadia/src/features/payment/presentation/view/send_money_details.dart';
import 'package:njadia/src/features/onboarding/onboardingScreen.dart';
import 'package:njadia/main.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_group_contact.dart';
import 'package:njadia/src/features/group_chat/presentation/view/group_template_option.dart';
import 'package:njadia/src/features/group_chat/presentation/view/join_group.dart';
import 'package:njadia/src/features/profile/presentation/views/profile.dart';
import '../features/home/presentation/view/home.dart';
import '../features/authentication/screens/signup/views/signup.dart';

class AppRoutes {
  static const String SPLASHSCREEN = '/';
  static const String ONBOARDING = '/onBoarding';
  static const String SIGNUP = '/signup';
  static const String LOGIN = '/login';
  static const String CHAT_SIGNUP = '/signupChat';
  static const String CHAT_LOGIN = '/loginChat';
  static const String HOMEpAGE = '/homepage';
  static const String CREATE_GROUP_TEMPLATE = '/createGroupTemplate';
  static const String JOINGROUP = '/joinGroup';
  static const String ADDCONTACT = '/addContacts';
  static const String GROUP_CATEGORYg = '/group_category';
  static const String CREATE_GROUP = '/create_group';
  static const String ADD_USERS_LINK = '/add_users_link';
  static const String GROUP_MENU_PAGE = '/group_menu_page';
  static const String GROUP_HOME_PAGE = '/group_home_page';
  static const String SEND_MONEY_PAGE = '/send_money';
  static const String SELECT_GROUP_MEMBER_PAGE = '/select_group_member';
  static const String SEND_MONEY_DETAIL_PAGE = '/send_money_detail';

  static const String PROFILE = '/profile';
  static const String SEARCH = '/search';
  static const String DIRECT_MESSAGE = '/directMessages';
  static const String CHATPAGE = '/chatPage';

  

  String intialScreen() => SPLASHSCREEN;
}

class AppPages {
  static List<GetPage> appPagas = [
    GetPage(name: AppRoutes.SPLASHSCREEN, page: () => const SplashScreen()),
    GetPage(
        name: AppRoutes.ONBOARDING,
        page: () => OnBoardingScreens(),
        binding: BindingsBuilder(() {})),
    GetPage(name: AppRoutes.SIGNUP, page: () => Signup()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginScreen()),
    // GetPage(name: AppRoutes.CHAT_SIGNUP, page: () =>const SignupChat()),
    // GetPage(name: AppRoutes.CHAT_LOGIN, page: () =>const LoginChat()),
    GetPage(name: AppRoutes.HOMEpAGE, page: () => const HomePage()),
    GetPage(
        name: AppRoutes.CREATE_GROUP_TEMPLATE,
        page: () => const GroupTemplateOption()),
    GetPage(name: AppRoutes.JOINGROUP, page: () => JoinGroup()),
    GetPage(name: AppRoutes.ADDCONTACT, page: () =>const AddContacts()),
    GetPage(name: AppRoutes.GROUP_CATEGORYg, page: () =>const  GroupCategory(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: AppRoutes.CREATE_GROUP, page: () => const CreateGroup(),
     transition: Transition.downToUp,
    transitionDuration: const Duration(milliseconds: 300)
    ),
    GetPage(name: AppRoutes.ADD_USERS_LINK, page: () => AddUserLink()),
    GetPage(name: AppRoutes.GROUP_MENU_PAGE, page: () => const GroupMenuPage()),
    GetPage(name: AppRoutes.GROUP_HOME_PAGE, page: () => const GroupHomePage()),
    GetPage(
        name: AppRoutes.SELECT_GROUP_MEMBER_PAGE,
        page: () => const SelectGroupMember()),
    GetPage(name: AppRoutes.SEND_MONEY_PAGE, page: () => const SendMoney()),
    GetPage(
        name: AppRoutes.SEND_MONEY_DETAIL_PAGE, page: () => SendMoneyDetail()),

    GetPage(name: AppRoutes.PROFILE, page: () => Profile()),
    GetPage(name: AppRoutes.SEARCH, page: () => SearchGroups()),
     GetPage(name: AppRoutes.DIRECT_MESSAGE, page: () => DirectMessage()),
    //  GetPage(name: AppRoutes.CHATPAGE, page: () => ChatPage()),
  ];
}
