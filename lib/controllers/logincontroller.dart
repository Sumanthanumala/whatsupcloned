import 'package:whatsupclone/utils/export.dart';

class Logincontroller extends GetxController {
  var phoneNumberController = TextEditingController();
  var countryCodeController = TextEditingController();
  var countryNameController = TextEditingController();

  verify(BuildContext context) async {
    try {
      final phone = phoneNumberController.text;
      final country = countryNameController.text;
      final code = countryCodeController.text;
      if (phone.isEmpty || country.isEmpty || code.isEmpty) {
        showalertdialog(context: context, message: 'Enter valid details');
      } else if (phone.length <= 9) {
        showalertdialog(
            context: context,
            message: 'Entered number is too short please enter valid details');
      } else if (phone.length > 10) {
        showalertdialog(
            context: context,
            message: 'Entered number is too long please enter valid details');
      } else {
        showLoadingDialog(context: context, message: 'Sending code');

        await auth.verifyPhoneNumber(
          phoneNumber: '+$code $phone',
          verificationCompleted: (phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            showalertdialog(context: context, message: error.toString());
          },
          codeSent: (verificationId, forceResendingToken) {
            Get.toNamed(Wverify, arguments: {
              "verficationId": verificationId,
              "phone": phone,
              "code": code
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
      }
    } catch (e) {
      Get.back();
      showalertdialog(context: context, message: 'Something went wrong. Try again');
    }
  }
}
