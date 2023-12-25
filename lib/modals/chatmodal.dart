class Chatmodal {
  String name;
  String currentmessage;
  bool isgroup;
  String icon;
  String time;
  bool isselected=false;

  Chatmodal(
      { required this.currentmessage,
      required this.icon,
      required this.isgroup,
      required this.name,
      required this.time,
       this.isselected=false});
}
