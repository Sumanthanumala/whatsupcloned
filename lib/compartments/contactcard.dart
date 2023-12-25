

import 'package:whatsupclone/modals/usermodal.dart';
import 'package:whatsupclone/utils/export.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.contactSource,
    required this.onTap,
  }) : super(key: key);

  final UserModel contactSource;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.withOpacity(.3),
        radius: 20,
        
        child: contactSource.profileImageUrl.isEmpty
            ? const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              )
            : null,
      ),
      title: Text(
        contactSource.username,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: contactSource.uid.isNotEmpty
          ? const Text(
              "Hey there! I'm using WhatsApp",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      trailing: contactSource.uid.isEmpty
          ? TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
              ),
              child: const Text('INVITE'),
            )
          : null,
    );
  }
}
