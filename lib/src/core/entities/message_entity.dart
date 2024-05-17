import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String messageId;
  final String message;
  final String messageSender;
  final String messageReceiver;
  final String replySender;
  final String replyMessage;
  final String chatId;
  final String dateTime;

  const MessageEntity(
      {required this.messageId,
      required this.message,
      required this.messageReceiver,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
      required this.chatId,
      required this.dateTime});

  @override
  List<Object?> get props => [
        messageId,
        messageReceiver,
        messageSender,
        replyMessage,
        replySender,
        dateTime,
        chatId
      ];
}
