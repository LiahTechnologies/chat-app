

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/payment/presentation/bloc/group-event.dart';
import 'package:njadia/src/features/payment/presentation/bloc/group-state.dart';

import '../../domain/usecases/get-group-members-usecase.dart';

class GroupMemberBloc extends Bloc<GroupMemberEvent,GroupMemberState>{

 final GetGroupMemberUsecase getGroupMemberUsecase;
  GroupMemberBloc({required this.getGroupMemberUsecase}):super(GroupMemberEmtpy()){

    on<OnFetchMembers>((event,emit)async{
      emit(GroupMemberLoading());
      final result = await getGroupMemberUsecase.call(groupId:event.groupId);
      result.fold((l)=>emit(GroupMemberError(error: "Error Loading members")), (data)=>emit(GroupMemberLoaded(memebrs: data)));
    });
  }

}