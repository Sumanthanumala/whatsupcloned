import 'package:whatsupclone/utils/export.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final IconData ?leading;
  final Widget ?trailing;
  final String ?subtitle;

  const CustomListTile(
      {super.key,
      required this.text,
      this.leading,
      this.trailing,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(text),
        leading: Icon(leading),
        trailing: trailing,
        subtitle: subtitle!=null ? Text(subtitle!):null);
  }
}