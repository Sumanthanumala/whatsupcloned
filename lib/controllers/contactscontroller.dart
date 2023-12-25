import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsupclone/utils/export.dart';

class ContactsController extends GetxController {
  RxList<Contact> contactsinphone = <Contact>[].obs;
  RxList<UserModel> firebaseContacts = <UserModel>[].obs;
  RxList<UserModel> phoneContacts = <UserModel>[].obs;

  getpermissions() async {
    if (await Permission.contacts.isGranted) {
      await getallcontacts();
    } else {
      await Permission.contacts.request();
    }
  }

  getallcontacts() async {
    List<UserModel> firebasecontacts = [];
    List<UserModel> phonecontacts = [];
    final result = await ContactsService.getContacts();
    contactsinphone.assignAll(result);

    if (contactsinphone.isNotEmpty) {
      print('notempty');
      bool iscontactfound = false;

      for (var contact in contactsinphone) {
        if (contact.phones!.isNotEmpty) {
          print('object');
          final usercollection = await firestore.collection("Users").get();
          for (var firebasecontactdata in usercollection.docs) {
            final firbasecontact =
                UserModel.fromMap(firebasecontactdata.data());
            if (contact.phones![0].value == firbasecontact.phoneNumber) {
              print('contact mateched');
              print(firbasecontact.phoneNumber);
              firebasecontacts.add(firbasecontact);
              iscontactfound = true;
              break;
            }
          }
          if (!iscontactfound) {
            phonecontacts.add(UserModel(
                username: contact.displayName.toString(),
                uid: '',
                profileImageUrl: '',
                active: false,
                pushtoken: '',
                phoneNumber: contact.phones![0].value.toString(),
                groupId: [], lastseen: 0));
          }
          iscontactfound = false;
        }
      }
    } else {
      print('contacts is empty');
    }
    firebaseContacts.value=firebasecontacts;
    phoneContacts.value=phonecontacts;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getpermissions();
  }

  sendsms(String phonenumber, String message )async {
    final Uri url=Uri(scheme: 'sms',path: phonenumber,queryParameters: {'body':message});
    if(await canLaunchUrl(url)){
        await launchUrl(url);
    }else{
      print('could not send sms');
    }
  }
}