import 'package:whatsupclone/enums/messagetype.dart';
import 'package:whatsupclone/modals/messagemodal.dart';
import 'package:whatsupclone/utils/export.dart';
import 'package:uuid/uuid.dart';

class IndividualChatController extends GetxController {
  var message = ''.obs;
  var emojienable = false.obs;
  var focusNode = FocusNode();
  var msgcontroller = TextEditingController();
  ScrollController scrollcontroller = ScrollController();
  ScrollController controller = ScrollController();
  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emojienable.value = false;
      }
    });
  }

  sendtextmessage(
      {required String lastMessage,
      required String receiverid,
      required BuildContext context,
      required UserModel senderdata}) async {
    try {
      final timesent = DateTime.now();
      final receiverdatamap =
          await firestore.collection('Users').doc(receiverid).get();
      final receiverdata = UserModel.fromMap(receiverdatamap.data()!);
      final textMessageId = const Uuid().v1();

      FirebaseStorageRepositary().sendmessagetocollection(
          receiverid: receiverid,
          timeSent: timesent,
          textmessage: lastMessage,
          textMessageId: textMessageId,
          senderUsername: senderdata.username,
          receiverUsername: receiverdata.username,
          messageType: MessageType.text);
      FirebaseStorageRepositary().saveaslastmessage(
          senderdata: senderdata,
          receiverdata: receiverdata,
          lastmessage: lastMessage,
          receiverid: receiverid,
          timesent: timesent);
      FirebaseStorageRepositary().sendnotification(lastMessage,senderdata,receiverid);

    } catch (e) {
      showalertdialog(context: context, message: "something went wrong");
    }
  }

  Stream<List<MessageModel>> getallonetoonemessages(
      {required String receiverid}) {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverid)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];

      for (var message in event.docs) {
        messages.add(MessageModel.fromMap(message.data()));
      }
      return messages;
    });
  }

  sendFileMessage({
    required var file,
    required BuildContext context,
    required String receiverId,
    required UserModel senderData,
    required MessageType messageType,
  }) async {
    final messageid = const Uuid().v1();
    final timesent = DateTime.now();
    print(messageid);
    final receiverdata =
        await firestore.collection('Users').doc(receiverId).get();
    final receiver = UserModel.fromMap(receiverdata.data()!);
    final imageurl = await FirebaseStorageRepositary()
        .uploadimage(file, 'chats/${senderData.uid}/$receiverId/$messageid');

    String lastMessage;

    switch (messageType) {
      case MessageType.image:
        lastMessage = '📸 Photo message';
        break;
      case MessageType.audio:
        lastMessage = '📸 Voice message';
        break;
      case MessageType.video:
        lastMessage = '📸 Video message';
        break;
      case MessageType.gif:
        lastMessage = '📸 GIF message';
        break;
      default:
        lastMessage = '📦 GIF message';
        break;
    }
    
    FirebaseStorageRepositary().sendmessagetocollection(
        receiverid: receiverId,
        timeSent: timesent,
        textMessageId: messageid,
        senderUsername: senderData.username,
        textmessage: imageurl,
        receiverUsername: receiver.username,
        messageType: messageType);

    FirebaseStorageRepositary().saveaslastmessage(
        senderdata: senderData,
        receiverdata: receiver,
        lastmessage: lastMessage,
        receiverid: receiverId,
        timesent: timesent);
  }
}