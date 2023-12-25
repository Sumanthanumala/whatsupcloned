import 'package:whatsupclone/utils/export.dart';

class Customcard extends StatelessWidget {
  final Chatmodal chat;

  const Customcard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Windividualchat,arguments: chat),
      child: ListTile(
        title: Text(
          chat.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(children: [
          const Icon(Icons.done_all_rounded),
          const SizedBox(
            width: 5.0,
          ),
          Text(chat.currentmessage),
        ]),
        leading: CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.4),
          child: chat.isgroup
              ? const Icon(Icons.groups_2_rounded,
                  color: Colors.white, size: 32)
              : const Icon(Icons.person, color: Colors.white, size: 32),
        ),
        trailing: Text(chat.time, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}