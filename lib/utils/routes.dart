import 'package:whatsupclone/utils/export.dart';

class Routes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: Wcontact,
      page: () => ContatctsPage(),
    ),
    
    GetPage(
      name: Whome,
      page: () => MyHomePage(),
    ),
    GetPage(
      name: Wuserinfo,
      page: () => UserInfoPage(),
    ),
    GetPage(
      name: Wverify,
      page: () => VerificationPage(),
    ),
    GetPage(
      name: Wlogin,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Wwelcome,
      page: () => WelcomePage(),
    ),
    
  ];
}
