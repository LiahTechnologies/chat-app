
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/group_chat/data/model/group_chat_model.dart';
import '../../../../core/entities/message_entity.dart';
import '../../../group_chat/domain/usecase/group-socket-usecase.dart';
import 'group-socket-event.dart';
import 'group-socket-state.dart';

// import 'socket_event.dart';
// import 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  final ConnectSocket connectSocket;
  final DisconnectSocket disconnectSocket;
  final SendMessage sendMessage;
  final OnMessage onMessage;
  final FetchInitialMessages fetchInitialMessages;
  final AddChatUseCase addChatUseCase;
  // final GenerateBallotNumbersUsecase generateBallotNumbersUsecase;

  SocketBloc({
    required this.addChatUseCase,
    required this.connectSocket,
    required this.disconnectSocket,
    required this.sendMessage,
    required this.onMessage,
    required this.fetchInitialMessages,
    // required this.generateBallotNumbersUsecase
  }) : super(SocketInitialState()) {
    on<ConnectSocketEvent>((event, emit)  {
      emit(SocketConnectingState());
      try {
        connectSocket.call();
       if(!emit.isDone) emit(SocketConnectedState());
      } catch (e) {
        if(!emit.isDone) emit(SocketErrorState(e.toString()));
      }
    });

    on<DisconnectSocketEvent>((event, emit) {
      disconnectSocket.call();
      if (!emit.isDone) emit(SocketDisconnectedState());
    });

    on<SendMessageEvent>((event, emit) {
       sendMessage.call(event.event, event.data);
    });


    on<OnMessageEvent>((event, emit) async  {


    //  final result = await onMessage.call(event.event);
    //          emit(SocketMessageReceivedState(result));

      // await onMessage.call(event.event, (data) async  {
      //   final newMessage =await GroupChatModel.fromJson(data);
      //   print("emitted message is $newMessage");

      //   if(!emit.isDone)      
      //   emit(SocketMessageReceivedState(data));
        
      // });
    });



    on<FetchInitialMessagesEvent>((event, emit)  async{

      try {
        final messages = await fetchInitialMessages.call(event.groupId);
        if (!emit.isDone) emit(InitialMessagesFetchedState(messages));
      } catch (e) {
        print("Error HMM ${e.toString()}");
        if (!emit.isDone) emit(SocketErrorState(e.toString()));
      }
     
    });


  on<OnAddChat>((event, emit)async{
    final result = await addChatUseCase.repository.addChat(uid: event.uid, receiverId: event.receiverId);
    result.fold((l)=>emit(SocketErrorState("Error adding chats")), (data)=>emit(PrivateChatCreated(data)));
  });


    // on<OnGenerateBallotsNumbers>((event, emit) async {
    //   try {
    //     print("BALLOT EVENT");
    //     final result = await generateBallotNumbersUsecase.generateBallots(groupId: event.groupId);
    //     result.fold((l)=>emit(SocketErrorState( "Error")), (data)=>emit(GroupBallotsGenerated()));

    //   } catch (e) {
    //     emit(SocketErrorState("Error Sending Message"));
    //   }
    // });


  }



}

