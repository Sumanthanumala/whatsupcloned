import 'package:whatsupclone/controllers/chathomecontroller.dart';
import 'package:whatsupclone/utils/export.dart';
import 'package:intl/intl.dart';
class ChatPage extends StatelessWidget {
  Chathomecontroller chathomecontroller =Get.put(Chathomecontroller());

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: chathomecontroller.getallmessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            
            itemBuilder: (context, index)   {
              
              final lastmessagedata = snapshot.data![index];
              
              return ListTile(
                onTap: () async {
                final userdata= await firestore.collection('Users').doc(lastmessagedata.contactId).get();
                final user=UserModel.fromMap(userdata.data()!);
                  Get.to(IndividualChat(
                    user: UserModel(
                        username: lastmessagedata.username,
                        uid: lastmessagedata.contactId,
                        profileImageUrl: lastmessagedata.profileImageUrl,
                        active: false,
                        pushtoken: user.pushtoken,
                        phoneNumber:  user.phoneNumber,
                        groupId: [],
                        lastseen: 0)));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                    backgroundImage: lastmessagedata.profileImageUrl.isNotEmpty
                        ? NetworkImage(lastmessagedata.profileImageUrl)
                        : null,
                        child: lastmessagedata.profileImageUrl.isEmpty ? const Icon(Icons.person,size: 24,):null),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(lastmessagedata.username),
                  Text(DateFormat.Hm().format(lastmessagedata.timeSent),maxLines: 1,)
                ]),
                subtitle: Text(lastmessagedata.lastMessage,maxLines: 1,
                overflow: TextOverflow.ellipsis),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Wcontact);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: const Color(0xFF075E54),
        child: const Icon(Icons.chat),
      ),
    );
  }
}