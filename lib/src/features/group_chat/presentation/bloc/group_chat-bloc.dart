import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/chats%20functionality/socketServicer.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/group_chat/domain/usecase/group_chat_usecase.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-event.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-state.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final GroupChatUsecase groupChatUsecase;
  final SocketService socketService;
  GroupChatBloc( this.groupChatUsecase, this.socketService) : super(GroupChatEmpty()) {
   

    on<OnSentGroupMessage>((event, emit) async {
      
      try {


      final response =
          await groupChatUsecase.sendMessage(event.message, event.groupId);

     emit( GroupChatSent());
        
      } catch (e) {
               emit(GroupChatError(error: "Error sending Message"));

      }
    });




    on<OnFetchGroupMessage>((event, emit) async{
     try {

       emit(GroupChatLoading());

      print("FETCHING ALL GROUPS FROM DATABASE");
      
      final result =  await groupChatUsecase.fetchMessage(event.groupId);
      result.fold((l) =>emit(GroupChatEmpty()) ,(data)=>emit(GroupChatLoaded(messages: data)));
      print("FETCHING ALL GROUPS FROM DATABASE");

      socketService.connect(event.groupId);
      socketService.onNewMessage((data){

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
      }});
  
   

  }
}


