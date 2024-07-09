import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/group_chat/domain/usecase/group_chat_usecase.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-event.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_chat-state.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final GroupChatUsecase groupChatUsecase;
  GroupChatBloc({required this.groupChatUsecase}) : super(GroupchatEmpty()) {
   

    on<OnSentGroupMessage>((event, emit) async {
      // emit(GroupChatLoading());

      final response =
          await groupChatUsecase.sendMessage(event.message, event.groupId);

     emit( GroupChatSent());
    });

    on<OnFetchGroupMessage>((event, emit) {
      emit(GroupChatLoading());

      return groupChatUsecase.fetchMessage(event.groupId);
    });


    on<OnDeleteGroupChat>((event, emit) {
      emit(GroupChatLoading());

      return groupChatUsecase.deleteMessage(event.messageEntity, event.groupId);
    });


   

  }
}


