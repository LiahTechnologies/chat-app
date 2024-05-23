import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/group_chat/domain/usecase/group_chat_usecase.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_event.dart';
import 'package:njadia/src/features/group_chat/presentation/bloc/group_state.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  final GroupChatUsecase groupChatUsecase;
  GroupChatBloc({required this.groupChatUsecase}) : super(GroupchatEmpty()) {
   

    on<OnGroupChatSent>((event, emit) {
      // emit(GroupChatLoading());

      final response =
          groupChatUsecase.sendMessage(event.message, event.groupId);

      GroupChatSentState(messages: response);
    });

    on<GroupChatLoad>((event, emit) {
      emit(GroupChatLoading());

      return groupChatUsecase.sendMessage(event.message, event.groupId);
    });
  }
}
