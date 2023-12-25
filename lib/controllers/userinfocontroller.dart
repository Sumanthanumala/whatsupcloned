import 'package:whatsupclone/utils/export.dart';

class Userinfocontroller extends GetxController {
  ImagePickercontroller imagePickercontroller =
      Get.put(ImagePickercontroller());
  var emojienable = false.obs;
  var focusNode = FocusNode();
  var usernameController = TextEditingController();

  savedatatofirebase(BuildContext context) async {
    String username = usernameController.text;
    if (username.isEmpty) {
      showalertdialog(context: context, message: 'Enter user name');
    } else {
      final token = await firebaseMessaging.getToken();
      print(token);
      return FirebaseStorageRepositary().savedata(
          context: context,
          username: username,
          token: token,
          profileImage: imagePickercontroller.image.value);
    }
  }
}