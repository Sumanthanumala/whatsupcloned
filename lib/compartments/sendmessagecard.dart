import 'package:whatsupclone/utils/export.dart';

class Sendmessagecard extends StatelessWidget {
  final String text;
  final String time;

   Sendmessagecard({super.key, required this.text, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250,minHeight: 10),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          color: const Color(0xFFdcf8c6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding:  const EdgeInsets.only(top: 5,bottom: 20,left: 10,right: 80),
                child: Text(text,style: const TextStyle(fontSize: 16),),
              ),
               Positioned(
                bottom: 4,right: 10,
                child: Row(children: [
                  Text(time,style: const TextStyle(fontSize: 12),),
                  const SizedBox(width: 5,),
                  const Icon(Icons.done_all,size: 12,)
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}