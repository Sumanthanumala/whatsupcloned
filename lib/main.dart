import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:whatsupclone/utils/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(handlebackgroundmessage);
  PendingDynamicLinkData? link =
      await FirebaseDynamicLinks.instance.getInitialLink();
  if (link != null) {
    final Uri deeplink = link.link;
    final path = deeplink.path;
    print(path);
  }
  FirebaseDynamicLinks.instance.onLink.listen(
    (pendingDynamicLinkData) {
      final Uri deepLink = pendingDynamicLinkData.link;
      final foregroundpath = deepLink.path;
      print(foregroundpath);
    },
  );
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> handlebackgroundmessage(RemoteMessage? message) async {
  final notification = message!.notification;
  if (notification != null) {
    print(notification.title);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                color: Color(0xFF075E54), foregroundColor: Colors.white)),
        getPages: Routes.routes,
        home: Spalshscreen());
  }
}