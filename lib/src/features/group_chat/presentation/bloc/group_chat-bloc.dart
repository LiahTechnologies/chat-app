import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/chats%20functionality/socketServicer.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/usecase/group_chat_usecase.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-event.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-state.dart';

import 'socketServicer.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final GroupChatUsecase groupChatUsecase;
  final GroupSocketService socketService;
  GroupChatBloc( this.groupChatUsecase, this.socketService) : super(GroupChatEmpty()) {
   
/*
    on<OnSentGroupMessage>((event, emit) async {
      
      try {


      final response =
          await groupChatUsecase.sendMessage(event.message, event.groupId);

      response.fold((l)=>emit(GroupChatEmpty()), (data)=>emit(GroupChatLoaded(messages: data)));
      print("STATE RESPONSE $response");
      socketService.connect(event.groupId);
      socketService.onNewGroupMessage((data){

        add(OnNewMessageReceived(messageEntity: MessageEntity(messageId: data["messageId"], message: data["message"], messageReceiver: data["messageReceiver"], messageSender: data["messageSender"], replyMessage: data["replyMessage"], replySender: data["replySender"], chatId: data["chatId"], dateTime: data["dateTime"])));
      });


     emit( GroupChatSent());
        
      } catch (e) {
               emit(GroupChatError(error: "Error sending Message"));

      }
    });

*/

    on<OnFetchGroupMessage>((event, emit) async {
      try {
        emit(GroupChatLoading());

        final result = await groupChatUsecase.fetchMessage(event.groupId);
        result.fold(
          (failure) => emit(GroupChatEmpty()),
          (messages) => emit(GroupChatLoaded(messages: messages)),
        );

      // print("state at state ${Right(result.length())}");

        print("FETCHING ALL GROUPS FROM DATABASE");

        socketService.connect(event.groupId);
        socketService.onNewGroupMessage((data) {
          add(OnNewMessageReceived(messageEntity: MessageEntity(
            messageId: data["_id"], 
            message: data["message"], 
            messageReceiver: data["receiverId"], 
            messageSender: data["senderId"]['lastNAme'], 
            replyMessage: data["replyMessage"], 
            replySender: data["replySender"], 
            chatId: data["chatId"], 
            dateTime: data["dateTime"],
          )));
        });

      } catch (e) {
        emit(GroupChatError(error: "Error Fetching Messages"));
      }
    });

    on<OnNewMessageReceived>((event, emit) {
      if (state is GroupChatLoaded) {
        final currentState = state as GroupChatLoaded;
        emit(GroupChatLoaded(messages: List.from(currentState.messages)..add(event.messageEntity)));
      }
    });



    on<OnSentGroupMessage>((event, emit) async {
      try {
        await groupChatUsecase.sendMessage(event.message, event.groupId);
        // Optionally emit a state or do nothing
      } catch (e) {
        emit(GroupChatError(error: "Error Sending Message"));
      }
    });
  }


/*

    on<OnFetchGroupMessage>((event, emit) async{
     try {

       emit(GroupChatLoading());

      print("FETCHING ALL GROUPS FROM DATABASE");
      
      final result =  await groupChatUsecase.fetchMessage(event.groupId);
      result.fold((l) =>emit(GroupChatEmpty()) ,(data)=>emit(GroupChatLoaded(messages: data)));
      print("FETCHING ALL GROUPS FROM DATABASE");

      socketService.connect(event.groupId);
      socketService.onNewGroupMessage((data){

        add(OnNewMessageReceived(messageEntity: MessageEntity(messageId: data["messageId"], message: data["message"], messageReceiver: data["messageReceiver"], messageSender: data["messageSender"], replyMessage: data["replyMessage"], replySender: data["replySender"], chatId: data["chatId"], dateTime: data["dateTime"])));
      });

     } catch (e) {
       emit(GroupChatError(error: "Error Fetching Messages"));
     }
      
    });




    on<OnDeleteGroupChat>((event, emit) async{
  
        try {

        emit(GroupChatLoading());

      final result = await groupChatUsecase.deleteMessage(event.messageEntity, event.groupId);
          
        } catch (e) {
                         emit(GroupChatError(error: "Error Deleting Message"));

        }
    });



  on<OnNewMessageReceived>((event, emit) {
      if (state is GroupChatLoaded) {
        final currentState = state as GroupChatLoaded;
        final updatedMessages = List<MessageEntity>.from(currentState.messages)..add(event.messageEntity);
        emit(GroupChatLoaded(messages:updatedMessages));
      }});*/
  
   

  
}


