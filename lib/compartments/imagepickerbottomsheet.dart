import 'package:whatsupclone/compartments/customicon.dart';
import 'package:whatsupclone/utils/export.dart';

class ImagePickerBottomsheet extends StatelessWidget {
   ImagePickerBottomsheet({super.key});
   ImagePickercontroller imagePickercontroller=Get.put(ImagePickercontroller());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(left: 24.0, top: 24),
            child: Text(
              'Profile Photo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Customicon(
                  ontap: () => imagePickercontroller.photopicked(context, ImageSource.camera),
                  color: Colors.transparent,
                  icon: Icons.camera_alt,
                  text: 'Camera',
                  iconcolor: const Color(0xFF00A884)),
              Customicon(
                ontap: () =>imagePickercontroller.photopicked(context, ImageSource.gallery),
                color: Colors.transparent,
                icon: Icons.photo,
                text: 'Gallery',
                iconcolor: const Color(0xFF00A884),
              )
            ],
          )
        ]),
      ),
    );
  }
}