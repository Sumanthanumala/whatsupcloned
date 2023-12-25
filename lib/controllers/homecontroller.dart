import 'package:whatsupclone/utils/export.dart';

class Homecontroller extends GetxController {
  getnotifications() {
    FirebaseStorageRepositary().fnotification();
  }

  @override
  void onInit() {
    super.onInit();
    getnotifications();
  }
}