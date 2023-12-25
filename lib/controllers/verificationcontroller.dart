import 'package:whatsupclone/modals/usermodal.dart';
import 'package:whatsupclone/utils/export.dart';

class Verificationcontroller extends GetxController {
  Logincontroller logincontroller = Get.put(Logincontroller());
  var pincontroller = TextEditingController();
  var enteredotp = ''.obs;
  var number = '';
  var code = '';
  var verifcationid = ''.obs;
  int? token;

  @override
  void onInit() {
    super.onInit();
    final receivedarguments = Get.arguments;
    number = receivedarguments["phone"];
    code = receivedarguments["code"];
    verifcationid.value = receivedarguments["verficationId"];
  }

  Future<void> verifyotp(BuildContext context) async {
    try {
      showLoadingDialog(context: context, message: 'Verifying');

      if (pincontroller.text.isEmpty) {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verifcationid.value, smsCode: enteredotp.value);

        await auth.signInWithCredential(credential);
        Get.toNamed(Wuserinfo,);
      } else {
        showalertdialog(context: context, message: 'Enter valid OTP');
      }
    } catch (e) {
      Get.back();
      showalertdialog(
          context: context, message: e.toString());
    }
  }

  Future<void> resendotp(BuildContext context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+$code $number',
      forceResendingToken: token,
      verificationCompleted: (phoneAuthCredential) async {
        await auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        showalertdialog(context: context, message: error.toString());
      },
      codeSent: (verificationId, forceResendingToken) {
        token = forceResendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
