import 'package:whatsupclone/utils/export.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
 final Logincontroller logincontroller = Get.put(Logincontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Verify your phone number',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blueGrey),
        ),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'WhatsApp will need to verify your account.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  onSelect: (value) {
                    logincontroller.countryNameController.text = value.name;
                    logincontroller.countryCodeController.text =
                        value.phoneCode;
                  },
                );
              },
              controller: logincontroller.countryNameController,
              readOnly: true,
              hintText: 'Select Country',
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF00A884),
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    controller: logincontroller.countryCodeController,
                    prefixText: '+',
                    hintText: 'code',
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    controller: logincontroller.phoneNumberController,
                    hintText: 'phone number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Carrier charges may apply',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 90,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: const Color(0xFF00A884)),
            onPressed: () => logincontroller.verify(context),
            child: const Text('Next')),
      ),
    );
  }
}