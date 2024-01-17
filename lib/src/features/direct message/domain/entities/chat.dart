class Chat{
  final String chatId;
  final List<Map<String, dynamic >> messages;
  final List<Map<String, dynamic >> entities; 
  Chat({
    required this.chatId,
    required this.entities,
    required this.messages
  
  });
}
