import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
// import '../../domain/socket_use_cases.dart';
import '../../../group_chat/domain/usecase/group-socket-usecase.dart';
import '../../domain/usecase/socket-chat-usecase.dart';
import 'private-socket-event.dart';
import 'private-socket-state.dart';



class PrivateSocketBloc extends Bloc<SocketEvent, SocketState> {
  final PrivateConnectSocket connectSocket;
  final DisconnectPrivateSocket disconnectSocket;
  final SendPrivateMessage sendMessage;
  final OnPrivateMessage onMessage;
  final FetchInitialPrivateMessages fetchInitialMessages;

  PrivateSocketBloc({
    required this.connectSocket,
    required this.disconnectSocket,
    required this.sendMessage,
    required this.onMessage,
    required this.fetchInitialMessages,
  }) : super(SocketInitialState()) {
    on<ConnectSocketEvent>((event, emit)  {
      emit(SocketConnectingState());
      try {
        connectSocket.call();
        emit(SocketConnectedState());
      } catch (e) {
        emit(SocketErrorState(e.toString()));
      }
    });

    on<DisconnectSocketEvent>((event, emit) {
      disconnectSocket.call();
      emit(SocketDisconnectedState());
    });

    on<SendMessageEvent>((event, emit) {
       sendMessage.call(event.event, event.data);
    });


    on<OnMessageEvent>((event, emit) {
      onMessage.call(event.event, (data) async {
       
       final message = await MessageEntity(message: data["message"], messageSender: data["senderId"]['_id'], replyMessage: data["receiverId"], replySender: data["replySender"], time: data["time"],senderId: data['senderId'],receiverId: data['receiverId']);
        emit(SocketMessageReceivedState( message ));
        // add(OnMessageEventReceived(de_data));

        print("VALUE EMIITED  ${data}");
      });
    });



    on<FetchInitialMessagesEvent>((event, emit)  async{
      try {
      await fetchInitialMessages.call(event.groupId).then((messages)=> emit(InitialMessagesFetchedState(messages)));

        // print("THIS IS THE FETCHED MESSAGE ${messages}");


       
      } catch (e) { 
        print("Error HMM ${e.toString()}");
        emit(SocketErrorState(e.toString()));
      }
    });


  // on<OnAddChat>((event, emit)async{
  //   final result = await addChatUseCase.repository.addChat(uid: event.uid, receiverId: event.receiverId);
  //   result.fold((l)=>emit(SocketErrorState("Error adding chats")), (data)=>emit(PrivateChatCreated(data)));
  // });

    on<OnMessageEventReceived>((event, emit) {

    //     print("OnMessageEventReceived Triggered  ${event.message}");
    
    //  final newMessage =  MessageEntity.fromjson(event.message);
     
    //   emit(SocketMessageReceivedState(newMessage));


      // if (state is SocketConnectedState) {
      //   final currentState = state as SocketConnectedState;
      //   final updatedMessages = List<MessageEntity>.from(currentState.messages)..add(event.message);
      //   emit(SocketMessageReceivedState(updatedMessages));
      // }
    });
  }
}

