import 'package:whatsupclone/compartments/customlisttile.dart';
import 'package:whatsupclone/utils/export.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                          color: Colors.black,
                        ),
                      ],
                    ),
                    CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        backgroundImage: user.profileImageUrl.isNotEmpty
                            ? NetworkImage(user.profileImageUrl)
                            : null,
                        child: user.profileImageUrl.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 40,
                              )
                            : null),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      user.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(user.phoneNumber,
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icons(Icons.call, 'Audio'),
                        const SizedBox(
                          width: 12,
                        ),
                        icons(Icons.video_call, 'Video'),
                        const SizedBox(
                          width: 12,
                        ),
                        icons(Icons.currency_rupee, 'Pay'),
                        const SizedBox(
                          width: 12,
                        ),
                        icons(Icons.search, 'Search')
                      ],
                    ),
                  ],
                ),
              )),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                const CustomListTile(text: 'Hey I am using WhatsApp'),
                const SizedBox(height: 10,),
                CustomListTile(
                    text: 'Mute notifications',
                    leading: Icons.notifications,
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    )),
                const SizedBox(
                  height: 10,
                ),
                const CustomListTile(
                    text: 'Custom Notification', leading: Icons.music_note),
                const SizedBox(
                  height: 10,
                ),
                CustomListTile(
                    text: 'Media visibility',
                    leading: Icons.photo,
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    )),
                const SizedBox(
                  height: 20,
                ),
                const CustomListTile(
                  text: 'Encryption',
                  leading: Icons.lock,
                  subtitle:
                      'Messages and calls are end-to-end encrypted. Tap to Verify',
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomListTile(
                    text: 'Disappearing Messages',
                    leading: Icons.timer_sharp,
                    subtitle: 'Off'),
                const SizedBox(
                  height: 10,
                ),
                const CustomListTile(
                    text: 'Chat lock', leading: Icons.mail_lock_outlined),
                ListTile(
                  leading: const CircleAvatar(
                      backgroundColor: Color(0xFF075E54),
                      foregroundColor: Colors.white,
                      child: Icon(Icons.group)),
                  title: Text('Create Group with ${user.username}'),
                ),
                ListTile(
                  leading: const Icon(Icons.block, color: Colors.red),
                  title: Text(
                    'Block ${user.username}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.thumb_down,
                    color: Colors.red,
                  ),
                  title: Text('Report ${user.username}',
                      style: const TextStyle(color: Colors.red)),
                ),
                SizedBox(height: 30,)
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget icons(IconData icon, String text) {
  return Column(
    children: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            size: 24,
            color: const Color(0xFF075E54),
          )),
      Text(
        text,
        style: const TextStyle(fontSize: 16, color: Color(0xFF075E54)),
      ),
    ],
  );
}