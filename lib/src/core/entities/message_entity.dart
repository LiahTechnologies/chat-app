import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String messageId;
  final String messageSender;
  final String messageReceiver;
  final String replySender;
  final String replyMessage;
  final DateTime dateTime;

  const MessageEntity(
      {required this.messageId,
      required this.messageReceiver,
      required this.messageSender,
      required this.replyMessage,
      required this.replySender,
      required this.dateTime});

  @override
  List<Object?> get props => [
        messageId,
        messageReceiver,
        messageSender,
        replyMessage,
        replySender,
        dateTime
      ];
}
