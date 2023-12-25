import 'package:whatsupclone/utils/export.dart';

class Spalshscreen extends StatelessWidget {
   Spalshscreen({super.key});

  SplashscreenController splashscreenController =Get.put(SplashscreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/logo.png',width: 150,height: 150,)),
    );
  }
}
