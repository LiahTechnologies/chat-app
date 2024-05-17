class ChatModel {
  ChatModel(
      {required this.name,
      required this.icon,
      required this.isGroup,
      required this.time,
      required this.status,
      this.isSelected=false,
      required this.currentMessage});
  String name;
  String icon;
  bool isGroup;
  String time;
  String status;
  bool isSelected;
  String currentMessage;
}
