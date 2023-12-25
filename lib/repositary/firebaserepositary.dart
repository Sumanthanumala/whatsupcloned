import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsupclone/enums/messagetype.dart';
import 'package:whatsupclone/modals/lastmessagemodal.dart';
import 'package:whatsupclone/modals/messagemodal.dart';
import 'package:whatsupclone/utils/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', 'High Priority Notification',
    showBadge: true,
    description: 'your channel Description',
    importance: Importance.high);


class FirebaseStorageRepositary {
  SplashscreenController splashscreenController =
      Get.put(SplashscreenController());

  Future<String> uploadimage(var file, String filename) async {
    final ref = firebaseStorage.ref().child(filename);

    UploadTask? uploadTask;
    if (file is File) {
      uploadTask = ref.putFile(file);
    }
    if (file is Uint8List) {
      uploadTask = ref.putData(file);
    }
    TaskSnapshot snapshot = await uploadTask!;
    String imageurl = await snapshot.ref.getDownloadURL();
    return imageurl;
  }

  savedata({
    required BuildContext context,
    required String username,
    required var profileImage,
    required var token,
  }) async {
    try {
      showLoadingDialog(context: context, message: 'Saving user info..');

      String uid = auth.currentUser!.uid;
      String profileImageUrl = '';
      if (profileImage != null) {
        profileImageUrl = await uploadimage(profileImage, 'profileimages/$uid');
      }

      final user = UserModel(
          pushtoken: token,
          username: username,
          uid: uid,
          profileImageUrl: profileImageUrl,
          active: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: [],
          lastseen: DateTime.now().millisecondsSinceEpoch);

      await firestore.collection('Users').doc(uid).set(user.toMap());
      Get.toNamed(Whome);
    } catch (e) {
      showalertdialog(
          context: context, message: 'Something went wrong. Try again');
    }
  }

  Future<UserModel?>? getuserinfo() async {
    UserModel? user;
    final userinfo =
        await firestore.collection("Users").doc(auth.currentUser!.uid).get();

    if (userinfo.data() != null) {
      user = UserModel.fromMap(userinfo.data()!);
      return user;
    } else {
      return user;
    }
  }

  sendmessagetocollection({
    required receiverid,
    required timeSent,
    required textMessageId,
    required senderUsername,
    required textmessage,
    required receiverUsername,
    required messageType,
  }) async {
    final message = MessageModel(
        senderId: auth.currentUser!.uid,
        receiverId: receiverid,
        textMessage: textmessage,
        type: MessageType.text,
        timeSent: timeSent,
        messageId: textMessageId,
        isSeen: false);
    //sender
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());

    //receiver

    await firestore
        .collection('Users')
        .doc(receiverid)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(textMessageId)
        .set(message.toMap());
  }

  saveaslastmessage(
      {required UserModel senderdata,
      required UserModel receiverdata,
      required String lastmessage,
      required String receiverid,
      required DateTime timesent}) async {
    final receiverlastmessage = LastMessageModel(
        username: senderdata.username,
        profileImageUrl: senderdata.profileImageUrl,
        contactId: senderdata.uid,
        timeSent: timesent,
        lastMessage: lastmessage);

    await firestore
        .collection('Users')
        .doc(receiverid)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverlastmessage.toMap());

    final senderlastmessage = LastMessageModel(
        username: receiverdata.username,
        profileImageUrl: receiverdata.profileImageUrl,
        contactId: receiverdata.uid,
        timeSent: timesent,
        lastMessage: lastmessage);

    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverid)
        .set(senderlastmessage.toMap());
  }

  fnotification() async {
    await firebaseMessaging.requestPermission(
        badge: true, alert: true, sound: true);
    final token = await firebaseMessaging.getToken();
    if(token!=null){
      initpishnotification();
    }
  }

  void initpishnotification() {
    firebaseMessaging.getInitialMessage().then(handlemessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handlemessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        if (Platform.isAndroid) {
          localinitnotification(message);
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                iOS: const DarwinNotificationDetails(
                    presentSound: true,
                    presentBanner: true,
                    presentBadge: true,
                    presentAlert: true),
                android: AndroidNotificationDetails(channel.id, channel.name,
                    importance: Importance.high,
                    channelDescription: channel.description,
                    priority: Priority.high,
                    ticker: 'ticker')),
          );
        }
      }
    });
  }

  Future<void> localinitnotification(RemoteMessage message) async {
    var andriodinitialization = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosinitilization = const DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    var initilisationsettings = InitializationSettings(
        android: andriodinitialization, iOS: iosinitilization);

    await flutterLocalNotificationsPlugin.initialize(
      initilisationsettings,
      onDidReceiveNotificationResponse: (payload) {
        handlemessage(message);
      },
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> handlemessage(RemoteMessage? message) async {
    final notification = message?.notification;
    if (notification != null) {
      if(message!.data['type']=='chat'){
          print('object');
          final Udata = await firestore.collection('Users').doc(message.data['id']).get();
          final user= UserModel.fromMap(Udata.data()!);
          Get.to(IndividualChat(user: user));
      }
    }
  }

  sendnotification(String message,UserModel senderinfo, String receiverid) async {
    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    final userdata =
        await firestore.collection("Users").doc(receiverid).get();
    final user = UserModel.fromMap(userdata.data()!);
    var body = {
      "to": user.pushtoken,
      "notification": {
        "title": senderinfo.username,
        "body": message,
      },
      "data" :{
        'type' : 'chat',
        'id': senderinfo.uid
      }
    };
    final headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key="
    };
    final Response = await http.post(url, body: jsonEncode(body), headers: headers);
  }
}

//AAAAJiYryQM:APA91bE5MG-Mh-Sn_o76Slv-_wAUPDxLwgTjwsbzmRRGr7S0ZASnZJttr52cep2gnZYgPvWRpZQACV_41Y5UcUM1kKg_gLZWgXUfu-ZKxxNirtKiUt_F_Xt3bHWF76PaMekxy037ycJb
