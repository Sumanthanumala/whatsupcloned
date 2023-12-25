// import 'package:whatsupclone/controllers/contactscontroller.dart';
// import 'package:whatsupclone/utils/export.dart';

// class Getcontacts extends StatelessWidget {
//   ContactsController contactscontroller = Get.put(ContactsController());

//   Getcontacts({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => ListView.builder(
//           shrinkWrap: true,
//           primary: false,
//           itemCount: contactscontroller.contacts!.length,
//           itemBuilder: (context, index) {
//             final contact = contactscontroller.contacts?[index];
//             return InkWell(
//               onTap: () {},
//               child: ListTile(
//                 title: Text(contact!.displayName.toString()),
//                 subtitle: contact.phones!.isNotEmpty
//                     ? Text(contact.phones![0].value!)
//                     : const SizedBox(),
//                 leading: CircleAvatar(
//                     backgroundColor: const Color(0xFF075E54),
//                     foregroundColor: Colors.white,
//                     child: Text(contact.displayName![0])),
//               ),
//             );
//           },
//         ));
//   }
// }