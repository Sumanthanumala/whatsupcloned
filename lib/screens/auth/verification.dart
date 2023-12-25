import 'package:whatsupclone/utils/export.dart';

class VerificationPage extends StatelessWidget {
  final Verificationcontroller verificationcontroller =
      Get.put(Verificationcontroller());

  VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Verify your phone number',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blueGrey),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text:  TextSpan(children: [
                    const TextSpan(
                        text: 'WhatsApp will send a SMS to ',
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: "+${verificationcontroller.code} ${verificationcontroller.number}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ])),
              InkWell(
                onTap: () => Get.back(),
                child: const Text(
                  'Wrong Number',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Pinput(
                    length: 6,
                    onChanged: (value) {
                      verificationcontroller.enteredotp.value = value;
                    },
                    keyboardType: TextInputType.number),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter 6 digits code',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => verificationcontroller.resendotp(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message, color: Colors.grey),
                    SizedBox(width: 20),
                    Text(
                      'Resend SMS',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: Divider(
                  thickness: 2,
                  color: Colors.green.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 20),
                  Text(
                    'Call Me',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 90,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: const Color(0xFF00A884)),
              onPressed: () => verificationcontroller.verifyotp(context),
              child: const Text('Next')),
        ));
  }
}