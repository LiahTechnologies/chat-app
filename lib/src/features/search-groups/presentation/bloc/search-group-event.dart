
import 'package:njadia/src/features/group_chat/domain/entities/group_chat_entity.dart';

class SearchGroupEvent{}

class OnGroupFetch extends SearchGroupEvent{
  final String groupName;

  OnGroupFetch({required this.groupName});

}


class OnUserJoin extends SearchGroupEvent{
  final String groupId;
  OnUserJoin({required this. groupId});
}

class OnJoinGroup extends SearchGroupEvent{
  final String uid;
  final String groupId;

  OnJoinGroup({required this.uid, required this.groupId});
}

class OnClosePage extends SearchGroupEvent{}