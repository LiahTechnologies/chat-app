import 'dart:async';

import 'package:njadia/src/core/entities/message_entity.dart';

class StreamSocket{
  final _socketResponse= StreamController<MessageEntity>();

  void Function(MessageEntity) get addResponse => _socketResponse.sink.add;

  Stream<MessageEntity> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}