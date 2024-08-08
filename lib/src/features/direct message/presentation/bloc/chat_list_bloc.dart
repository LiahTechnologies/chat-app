import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/direct%20message/domain/usecase/chat_message_usecase.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_list_event.dart';
import 'package:njadia/src/features/direct%20message/presentation/bloc/chat_list_state.dart';

import '../../domain/usecase/chat_usecase.dart';

// class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
//   final ChatMessageUseCase chatMessageUseCase;
//   ChatMessageBloc({required this.chatMessageUseCase})
//       : super(ChatMessageEmpty()) {
//     on<OnChatMessageLoading>((event, emit) async {
//       final result = await chatMessageUseCase.execute(event.chatId);
//       result.fold((failure) => emit(ChatMessageErrorLoading()),
//           (data) => emit(ChatMessageLoaded(chatMessage: data)));
//     });
//   }
// }




class ChatListBloc extends Bloc<ChatEvent, ChatState> {
  final ChatListUsecase chatListUsecase;
  ChatListBloc({required this.chatListUsecase}) : super(ChatEmpty()) {

    on<OnFetchChats>((event, emit) async {

      final result = await chatListUsecase.execute();

      result.fold((failure) => emit(ChatErrorLoading()),
          (data) => emit(ChatLoaded(chat: data)));
    });
  }
}


