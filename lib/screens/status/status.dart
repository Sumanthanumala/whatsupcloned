import 'package:whatsupclone/utils/dynamiclinks.dart';
import 'package:whatsupclone/utils/export.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
          Image.asset('assets/icon.png',width: 250,height: 250,),
          const SizedBox(height: 10,),
          SizedBox(width: 100,
            child: ElevatedButton(onPressed: (){
              Dynamiclinkprovider().createdynamiclink();
            }, child: const Text("share url")),
          )
        ]),
      ),
    );
  }
}