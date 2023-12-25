import 'package:whatsupclone/utils/export.dart';

class ChatTextfield extends StatelessWidget {
  IndividualChatController individualChatController =
      Get.put(IndividualChatController());

  final String receiverid;
  final ScrollController scrollController;
  ChatTextfield({required this.receiverid, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: TextFormField(
                        controller: individualChatController.msgcontroller,
                        focusNode: individualChatController.focusNode,
                        onChanged: (value) {
                          individualChatController.message.value = value;
                        },
                        keyboardType: TextInputType.multiline,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 5,
                        minLines: 1,
                        cursorColor: const Color(0xFF075E54),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: individualChatController.message.isEmpty
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        IconButton(
                                            onPressed: () async {
                                              final userdata = await firestore
                                                  .collection('Users')
                                                  .doc(auth.currentUser!.uid)
                                                  .get();
                                              final senderdata =
                                                  UserModel.fromMap(
                                                      userdata.data()!);
                                              Get.bottomSheet(AttachFile(
                                                receiverId: receiverid,
                                                senderdata: senderdata,
                                              ));
                                            },
                                            icon: const Icon(Icons.attach_file),
                                            color: Colors.grey),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.camera_alt_outlined),
                                            color: Colors.grey)
                                      ])
                                : const SizedBox(),
                            prefixIcon: IconButton(
                                onPressed: () {
                                  individualChatController.focusNode.unfocus();
                                  individualChatController
                                      .focusNode.canRequestFocus = false;
                                  individualChatController.emojienable.value =
                                      !individualChatController
                                          .emojienable.value;
                                },
                                icon: const Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.grey,
                                )),
                            hintText: 'Message'),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF075E54),
                    child: IconButton(
                        onPressed: () async {
                          final userInfo = await firestore
                              .collection("Users")
                              .doc(auth.currentUser!.uid)
                              .get();
                          // ignore: use_build_context_synchronously
                          individualChatController.sendtextmessage(
                              context: context,
                              lastMessage:
                                  individualChatController.msgcontroller.text,
                              receiverid: receiverid,
                              senderdata: UserModel.fromMap(userInfo.data()!));
                          individualChatController.msgcontroller.clear();

                          scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        },
                        icon: individualChatController.message.isEmpty
                            ? const Icon(
                                Icons.mic,
                                size: 24,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.send,
                                size: 20,
                                color: Colors.white,
                              )),
                  ),
                ],
              ),
              individualChatController.emojienable.value
                  ? SizedBox(
                      width: double.infinity, height: 280, child: emojiselect())
                  : const SizedBox()
            ],
          ),
        ));
  }

  Widget emojiselect() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        individualChatController.msgcontroller.text =
            individualChatController.msgcontroller.text + emoji.emoji;
      },
      config: const Config(
        emojiSizeMax: 25,
      ),
    );
  }
}