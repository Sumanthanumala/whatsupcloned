import 'package:whatsupclone/controllers/contactscontroller.dart';
import 'package:whatsupclone/utils/export.dart';

class ContatctsPage extends StatelessWidget {
  ContatctsPage({super.key});

  ContactsController contactscontroller = Get.put(ContactsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select contact',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                Obx(() => Text(
                    '${contactscontroller.firebaseContacts.length} contacts',
                    style: const TextStyle(fontSize: 12)))
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ]),
        body: Obx(() => contactscontroller.firebaseContacts.isEmpty &&
                contactscontroller.phoneContacts.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                color: Color(0xFF075E54),
              ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text('New group'),
                        leading: CircleAvatar(
                            backgroundColor: Color(0xFF075E54),
                            foregroundColor: Colors.white,
                            child: Icon(Icons.group)),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const ListTile(
                        title: Text('New contact'),
                        leading: CircleAvatar(
                            backgroundColor: Color(0xFF075E54),
                            foregroundColor: Colors.white,
                            child: Icon(Icons.person_add)),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contactscontroller.firebaseContacts.length +
                            contactscontroller.phoneContacts.length,
                        itemBuilder: (context, index) {
                          if (index <
                              contactscontroller.firebaseContacts.length) {
                            final fcontact =
                                contactscontroller.firebaseContacts[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index == 0
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Text('Contacts on Whatsapp'),
                                      )
                                    : const SizedBox(),
                                InkWell(
                                  onTap: () =>Get.to(IndividualChat(user: fcontact)),
                                  child: ListTile(
                                    title: Text(fcontact.username),
                                    subtitle:
                                        const Text("Hey! I'm using whatsapp"),
                                    leading: CircleAvatar(
                                      foregroundColor: Colors.white,
                                      radius: 20,
                                      backgroundColor: Colors.grey,
                                      backgroundImage:
                                          fcontact.profileImageUrl.isNotEmpty
                                              ? NetworkImage(
                                                  fcontact.profileImageUrl)
                                              : null,
                                      child: fcontact.profileImageUrl.isEmpty
                                          ? Icon(Icons.person)
                                          : null,
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            final contact = contactscontroller.phoneContacts[
                                index -
                                    contactscontroller.firebaseContacts.length];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                index -
                                            contactscontroller
                                                .firebaseContacts.length ==
                                        0
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Text('Invite to Whatsapp'),
                                      )
                                    : const SizedBox(),
                                ListTile(
                                  title: Text(contact.username),
                                  trailing: ElevatedButton(
                                      onPressed: () => contactscontroller.sendsms(
                                          contact.phoneNumber,
                                          "Lets chat on whatsapp which is fast and secure. we can call each other. Get it at "),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF075E54),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const Text('Invite')),
                                  leading: const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey,
                                      foregroundColor: Colors.white,
                                      child: Icon(Icons.person)),
                                )
                              ],
                            );
                          }
                        })
                  ],
                ),
              )));
  }
}