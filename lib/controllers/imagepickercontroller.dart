import 'dart:io';

import 'package:whatsupclone/utils/export.dart';

class ImagePickercontroller extends GetxController {
  XFile? pickedimage;
  Rx<File?> image = Rx<File?>(null);

  photopicked(BuildContext context, ImageSource source) async {
    try{
      ImagePicker picker = ImagePicker();
    pickedimage = await picker.pickImage(source: source);
    if(pickedimage!=null){
      image.value=File(pickedimage!.path);
    }
    }catch(e){
      showalertdialog(context: context, message: e.toString());
    }
  }
}