// import 'package:whatsupclone/controllers/contactscontroller.dart';
// import 'package:whatsupclone/controllers/creategroupcontroller.dart';
// import 'package:whatsupclone/utils/export.dart';

// class Creategroup extends StatelessWidget {
//   Creategroup({super.key});
//   ContactsController contactscontroller = Get.put(ContactsController());
//   Creategroupcontroller creategroupcontroller =
//       Get.put(Creategroupcontroller());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Column(
//             children: [
//               Text('New group', style: TextStyle(fontSize: 18)),
//               Text(
//                 'Add Participants',
//                 style: TextStyle(fontSize: 12),
//               )
//             ],
//           ),
//           actions: [
//             IconButton(onPressed: () {}, icon: const Icon(Icons.search))
//           ]),
//       body: Obx(() => ListView.builder(
//             shrinkWrap: true,
//             primary: false,
//             itemCount: contactscontroller.contacts!.length,
//             itemBuilder: (context, index) {
//               final contact = contactscontroller.contacts?[index];
//               return InkWell(
//                 onTap: () {
//                 },
//                 child: ListTile(
//                   title: Text(contact!.displayName.toString()),
//                   subtitle: contact.phones!.isNotEmpty
//                       ? Text(contact.phones![0].value!)
//                       : const SizedBox(),
//                   leading: Stack(
//                     children: [
//                       SizedBox(width: 45,
//                         child: CircleAvatar(
//                             backgroundColor: const Color(0xFF075E54),
//                             foregroundColor: Colors.white,
//                             child: Text(contact.displayName![0])),
//                       ),
//                       creategroupcontroller.isselected.value==true ? const Positioned(top: 20,left: 25,
//                         child: CircleAvatar(
//                             backgroundColor: Colors.teal,
//                             radius: 10,
//                             foregroundColor: Colors.white,
//                             child: Icon(
//                               Icons.check,
//                               size: 14,
//                             )),
//                       ): const SizedBox(width: 0,height: 0,)
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )),
//     );
//   }
// }