import 'package:intl/intl.dart';
import 'package:whatsupclone/screens/chat/chattextfeild.dart';
import 'package:whatsupclone/utils/export.dart';

final pageStorageBucket = PageStorageBucket();

class IndividualChat extends StatelessWidget {
  final UserModel user;

  IndividualChatController individualChatController =
      Get.put(IndividualChatController());

  IndividualChat({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        titleSpacing: 5,
        title: InkWell(
          onTap: () => Get.to(ProfilePage(
            user: user,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.username),
              const SizedBox(
                height: 3,
              ),
              const Text(
                'last seen 2 mins ago',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(child: Text('View contact')),
                const PopupMenuItem(child: Text('Search')),
                const PopupMenuItem(child: Text('Wallpaper')),
                const PopupMenuItem(child: Text('Media')),
                const PopupMenuItem(child: Text('More')),
              ];
            },
          )
        ],
        leading: Row(children: [
          IconButton(
              onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: user.profileImageUrl.isNotEmpty
                ? NetworkImage(user.profileImageUrl)
                : null,
            child: user.profileImageUrl.isEmpty
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : null,
          )
        ]),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (individualChatController.emojienable.value) {
            individualChatController.emojienable.value =
                !individualChatController.emojienable.value;
          } else {
            Get.back();
          }
          return Future.value(false);
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: PageStorage(
                  bucket: pageStorageBucket,
                  child: StreamBuilder(
                    stream: individualChatController.getallonetoonemessages(
                        receiverid: user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        key: const PageStorageKey('chatpagekey'),
                        controller: individualChatController.scrollcontroller,
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!.length) {
                            return Container(
                              height: 10,
                            );
                          }
                          final message = snapshot.data![index];
                          final senderid =
                              message.senderId == auth.currentUser!.uid;

                          final now = DateTime.now();
                          final today = DateTime(now.year, now.month, now.day);
                          final showdatecard = (index == 0) ||
                              (message.timeSent.day >
                                  snapshot.data![index - 1].timeSent.day) ||
                              (message.timeSent.month >
                                  snapshot.data![index - 1].timeSent.month) || 
                                  (message.timeSent.year > snapshot.data![index-1].timeSent.year)
                          ;
                          return Column(
                            children: [
                              if (index == 0)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 30,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(68, 211, 195, 106),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Message and calls are end-to-end encrypted. No one outside of this chat, not even WhatsApp, can read or listen to them. Tap to learn more.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              if (showdatecard)
                                Text(message.timeSent.day == today.day
                                    ? 'Today'
                                    : DateFormat.yMMMd()
                                        .format(message.timeSent)),
                              senderid
                                  ? Sendmessagecard(
                                      text: message.textMessage,
                                      time: DateFormat('h:mm a')
                                          .format(message.timeSent),
                                    )
                                  : Receivedmessagecard(
                                      text: message.textMessage,
                                      time: DateFormat('h:mm a')
                                          .format(message.timeSent),
                                    ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ChatTextfield(
                    scrollController: individualChatController.scrollcontroller,
                    receiverid: user.uid,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
