

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/search-groups/domain/usecase/search-group-usecase.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-event.dart';
import 'package:njadia/src/features/search-groups/presentation/bloc/search-group-state.dart';

class SearchGroupBloc extends Bloc<SearchGroupEvent, SearchGroupState>{
  final SearchGroupUsecase searchGroupUsecase;
    SearchGroupBloc( this .searchGroupUsecase):super(Empty()){


         on<OnGroupFetch>((event, emit)async{
            emit(GroupLoading());
            
            final result = await searchGroupUsecase.call(event.groupName);

              result.fold((l)=>emit(ErrorSearchingGroup()), (data)=>emit(GroupLoaded(groupChatEntity: data)));

             });


          on<OnUserJoin> ((event, emit) async{
            final result = await searchGroupUsecase.hasUserJoined(event.groupId);
            result.fold((l)=>emit(ErrorSearchingGroup()), (data)=>emit(CheckUserJoinGroup(status: data)));
          })  ;


          on<OnJoinGroup>((event, emit)async{

              final result  = await  searchGroupUsecase.joinGroup(groupId: event.groupId, uid: event.uid);
              result.fold((l)=>emit(ErrorSearchingGroup()), (data)=>emit(UserJoinGroup(status: data)));
          });

            on<OnClosePage>((event, emit)async{

              emit(Empty());
          });
    }

   
}