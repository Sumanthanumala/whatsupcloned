import 'package:whatsupclone/compartments/customicon.dart';
import 'package:whatsupclone/enums/messagetype.dart';
import 'package:whatsupclone/utils/export.dart';

class AttachFile extends StatelessWidget {
   
   final String receiverId;
   final UserModel senderdata;
   AttachFile({required this.receiverId ,required this.senderdata});

    ImagePickercontroller imagePickercontroller =Get.put(ImagePickercontroller());
    IndividualChatController individualChatController =Get.put(IndividualChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Customicon(
                        color: Colors.indigo,
                        icon: Icons.insert_drive_file,
                        text: "Document"),
                    const Customicon(
                        color: Colors.pink,
                        icon: Icons.camera_alt,
                        text: "Camera"),
                    Customicon(
                        ontap: () {
                          imagePickercontroller.photopicked(context, ImageSource.gallery);
                          if(imagePickercontroller.image.value!=null){
                            print('imagepicker');
                            individualChatController.sendFileMessage(
                              file: imagePickercontroller.image.value, 
                              context: context, 
                              receiverId: receiverId, 
                              senderData: senderdata, 
                              messageType: MessageType.image);
                          }
                        },
                        color: Colors.purple,
                        icon: Icons.photo,
                        text: "Gallery"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Customicon(
                        color: Colors.orange,
                        icon: Icons.headphones,
                        text: "Audio"),
                    const Customicon(
                        color: Colors.green,
                        icon: Icons.location_on,
                        text: "Location"),
                    Customicon(
                        color: Colors.green.shade300,
                        icon: Icons.currency_rupee,
                        text: "Payment"),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Customicon(
                        color: Colors.blue,
                        icon: Icons.person,
                        text: "Contact"),
                    const SizedBox(
                      width: 40,
                    ),
                    Customicon(
                        color: Colors.green.shade300,
                        icon: Icons.poll_sharp,
                        text: "Poll"),
                  ],
                )
              ],
            )));
  }
}