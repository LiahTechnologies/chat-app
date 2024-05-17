import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/exceptions.dart';
import 'package:njadia/src/features/group_chat/data/model/group_list_model.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import '../../../../core/common/services/readjons.dart';
import '../../../../core/common/urls.dart';
import '../../../../core/entities/stream_socket.dart';

abstract class GroupListRemoteDataSource {
  Stream<GroupModel> fetchGroup({required String groupId});
   Future<List<GroupModel>> fetchGroups({required String groupId});

  Future<bool> deleteGroups({required String groupId});
}

class GroupListRemoteDataSourceImpl extends GroupListRemoteDataSource {
  final http.Client client;
  GroupListRemoteDataSourceImpl({required this.client});
  StreamSocket streamSocket = StreamSocket();

  @override
  Stream<GroupModel> fetchGroup({required String groupId}) async* {
    try {
      print("STREAMS OF MESSAGES BEING CALLED");

      // final response = await client
      //     .post(Uri.parse(AppUrls.BASEURL), body: {"userId": groupId});

      final groupJson = await readJson('lib/src/core/common/services/groups.json');

              // print("\n\n\nTHIS IS THE REMOTE DATA $groupJson");



      final message = await GroupModel.fromJson(groupJson['groups'][0]);
      print("\n\n\nTHIS IS THE REMOTE DATA $message");


      yield message;
    } on ServerExceptions {
      print("STREAMS OF MESSAGES FAILED");
      throw ServerExceptions();
    }
  }

  @override
  Future<bool> deleteGroups({required String groupId}) {
    // TODO: implement deleteGroups
    throw UnimplementedError();
  }
  
  @override
  Future<List<GroupModel>> fetchGroups({required String groupId})async {
    try {
      print("STREAMS OF MESSAGES BEING CALLED");

      // final response = await client
      //     .post(Uri.parse(AppUrls.BASEURL), body: {"userId": groupId});

      final groupJson = await readJson('lib/src/core/common/services/groups.json');

              // print("\n\n\nTHIS IS THE REMOTE DATA $groupJson");



      final message = await GroupModel.fromJson(groupJson['groups'][0]);
      print("\n\n\nTHIS IS THE REMOTE DATA $message");


      return [message];
    } on ServerExceptions {
      print("STREAMS OF MESSAGES FAILED");
      throw ServerExceptions();
    }
  }
}
