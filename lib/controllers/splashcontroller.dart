import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsupclone/utils/export.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  Future<void> navigate() async {
    User? user = auth.currentUser;
    DocumentSnapshot userinfo;
    Timer(const Duration(seconds: 2), () async {
      if (user != null) {
        userinfo =
            await firestore.collection('Users').doc(user.uid).get();
        bool isfirstlogin = userinfo.data() == null;

        if (isfirstlogin) {
          Get.toNamed(Wlogin);
        } else {
          Get.toNamed(Whome);
        }
      } else {
        Get.toNamed(Wwelcome);
      }
    });
  }
}