class UserModel {
  final String username;
  final String uid;
  final String profileImageUrl;
  final bool active;
  final int lastseen;
  final String phoneNumber;
  final List<String> groupId;
  final String pushtoken;

  UserModel({
    required this.username,
    required this.uid,
    required this.profileImageUrl,
    required this.active,
    required this.phoneNumber,
    required this.groupId,
    required this.lastseen,
    required this.pushtoken
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'profileImageUrl': profileImageUrl,
      'active': active,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
      'lastseen': lastseen,
      'pushtoken' : pushtoken
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      active: map['active'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
      lastseen: map['lastseen'] ?? 0,
      pushtoken: map['pushtoken']?? ''
    );
  }
}