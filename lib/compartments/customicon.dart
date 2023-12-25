import 'package:whatsupclone/utils/export.dart';

class Customicon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final Color ?iconcolor;
  final VoidCallback ?ontap;
  const Customicon({super.key, required this.color, required this.icon, required this.text,this.ontap,this.iconcolor});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color,
          child: IconButton(
              onPressed: ontap,
              icon: Icon(
                icon,
                color: iconcolor??Colors.white,
              )),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.grey),
        )
      ],
    );
  }
}
