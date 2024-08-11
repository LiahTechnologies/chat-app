// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupChatModelAdapter extends TypeAdapter<GroupChatModel> {
  @override
  final int typeId = 1;

  @override
  GroupChatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupChatModel(
      messageId: fields[0] as String?,
      message: fields[1] as String,
      messageReceiver: fields[3] as String?,
      messageSender: fields[2] as String,
      replyMessage: fields[6] as String,
      replySender: fields[5] as String,
      chatId: fields[4] as String?,
      senderId: fields[8] as String,
      receiverId: fields[9] as String,
      time: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupChatModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.messageId)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.messageSender)
      ..writeByte(3)
      ..write(obj.messageReceiver)
      ..writeByte(4)
      ..write(obj.chatId)
      ..writeByte(5)
      ..write(obj.replySender)
      ..writeByte(6)
      ..write(obj.replyMessage)
      ..writeByte(7)
      ..write(obj.time)
      ..writeByte(8)
      ..write(obj.senderId)
      ..writeByte(9)
      ..write(obj.receiverId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupChatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
