import 'package:whatsupclone/utils/export.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({super.key});

  Userinfocontroller userinfocontroller = Get.put(Userinfocontroller());
  ImagePickercontroller imagePickercontroller =
      Get.put(ImagePickercontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Profile info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Please provide your name and an optional profile \n photo',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              GestureDetector(onTap: () {
                Get.bottomSheet(isDismissible: true, ImagePickerBottomsheet());
              }, child: Obx(() {
                final selectedimage = imagePickercontroller.image.value;
                return selectedimage == null
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.4)),
                        child: const Padding(
                            padding: EdgeInsets.only(bottom: 3, right: 3),
                            child: Icon(
                              Icons.add_a_photo_rounded,
                              size: 48,
                              color: Colors.grey,
                            )),
                      )
                    : ClipOval(
                        child: Image.file(
                        selectedimage,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ));
              })),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomTextField(
                  controller: userinfocontroller.usernameController,
                  hintText: 'Type your name here',
                  textAlign: TextAlign.start,
                  focusNode: userinfocontroller.focusNode,
                ),
              ),
            ],
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
              onPressed: () => userinfocontroller.savedatatofirebase(context),
              child: const Text('Next')),
        ));
  }
}