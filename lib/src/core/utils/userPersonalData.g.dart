// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userPersonalData.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPersonalDataAdapter extends TypeAdapter<UserPersonalData> {
  @override
  final int typeId = 1;

  @override
  UserPersonalData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPersonalData(
      fields[2] as String,
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserPersonalData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.profilePic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPersonalDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
