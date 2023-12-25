import 'package:whatsupclone/compartments/showloadingdilogue.dart';
import 'package:whatsupclone/utils/export.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text('Welcome to whatsapp',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset(
              'assets/logo.png',
              width: 175,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Read our ',
                style: TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: 'Privacy Policy. ',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: 'Tap "Agree and continue" to accept the '),
                  TextSpan(
                    text: 'Terms of Services.',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A884),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  showLoadingDialog(context: context, message: 'Loading...');
                  Get.toNamed(Wlogin);
                },
                child: const Text('Agree and Continue')),
          )
        ],
      ),
    ));
  }
}