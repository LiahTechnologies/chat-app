import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../domain/entities/group_chat_entity.dart';
import '../../domain/usecase/group_chat_list_usecase_.dart';
import 'group_list_event.dart';
import 'group_list_state.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final GroupListUsecase groupListUsecase;
  GroupListBloc({required this.groupListUsecase})
      : super(GroupListState()) {
       


    // on<OnGroupsLoainding>((event, emit) async {
    //   print("ALL GROUPS STATE REACHING");
    //   emit(GroupEmpty());
    //   final result = groupListUsecase.fetch(event.groupId);
    //   emit(GroupListLoaded(groupChatEntity: result));

    //   //  await resulst.fold(emit(GroupListState()), (previous, element) =>emit(GroupListLoaded(groupChatEntity: element))
    //   // );
    // });
    // on<GroupListEvent>(_handleLoadGroupsList);

  on<OnGroupDelete>((event,emit)async{
    final result = await groupListUsecase.deleteGroup(event.groups);
    result.fold((l)=>emit(ErrorLoadingGroupList("Error")), (data)=>emit(GroupDeleted()));
  });


  on<OnFetchGroup>(_handleFetchGroup);

  on<OnFetchGroups>((event,emit)async{

      // try {
      //   await for (var users in groupListUsecase.execute()) {
      //     emit(GroupListLoaded(users));
      //   }
      // } catch (e) {
      //   emit(ErrorLoadingGroupList("Error Loading groups"));
      // }

    final result = await groupListUsecase.fetch();
    result.fold((l)=>emit(ErrorLoadingGroupList("Error Loading groups")), (data)=>emit(GroupListLoaded(data)));
  });

  }

  

  // Stream<GroupChatEntity> _handleLoadGroupsList(

  //     GroupListEvent event, Emitter<GroupListState> emit) async*  {
  //   // emit(GroupEmpty(groupListUsecase.execute("")));
  //   final result =  groupListUsecase.fetch(event.groupId);
  //   emit(GroupListState(groups: result));
  //   // result.fold(emit(GroupListState()), (previous, element) => emit(GroupListLoaded(groupChatEntity: yield result)));

  //   return result;GroupListEvent
  // }


  Stream<GroupListState>_handleFetchGroup(OnFetchGroup event, Emitter<GroupListState>emit)async*{


      //  emit(GroupListLoading());

      //     final result =  await groupListUsecase.fetch(event.groupId);
          
      //     yield GroupListLoaded(result); 
  }


  
}
 