import 'package:whatsupclone/controllers/homecontroller.dart';
import 'package:whatsupclone/utils/export.dart';


class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});

  Homecontroller homecontroller =Get.put(Homecontroller());


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'WhatsApp Clone',
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('New group'),
                  ),
                  const PopupMenuItem(child: Text('New broadcast')),
                  const PopupMenuItem(child: Text('Linked devices ')),
                  const PopupMenuItem(child: Text('Starred Messages')),
                  const PopupMenuItem(child: Text('Payments')),
                  const PopupMenuItem(child: Text('Settings')),
                ];
              },
            )
          ],
          bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Icon(
                  Icons.groups_2_rounded,
                ),
                Text('Chats'),
                Text('Status'),
                Text('Calls')
              ]),
        ),
        body: TabBarView(physics: const BouncingScrollPhysics(), children: [
          const Text('data'),
          ChatPage(),
          const StatusPage(),
          const CallsPage()
        ]),
      ),
    );
  }
}