import 'package:whatsupclone/modals/lastmessagemodal.dart';
import 'package:whatsupclone/utils/export.dart';

class Chathomecontroller extends GetxController{


    Stream<List<LastMessageModel>> getallmessages() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      final List<LastMessageModel> contact = [];
      for (var document in event.docs) {
        final lastmessage = LastMessageModel.fromMap(document.data());
        final userdata = await firestore
            .collection('Users')
            .doc(lastmessage.contactId)
            .get();
        final user = UserModel.fromMap(userdata.data()!);
        contact.add(LastMessageModel(
            username: user.username,
            profileImageUrl: user.profileImageUrl,
            contactId: lastmessage.contactId,
            timeSent: lastmessage.timeSent,
            lastMessage: lastmessage.lastMessage));
      }
      return contact;
    });
  }

  
}