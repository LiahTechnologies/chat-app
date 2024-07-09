import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/create_group/domain/usecases/add-admin-usecase.dart';
import 'package:njadia/src/features/create_group/domain/usecases/add-member-usecase.dart';
import 'package:njadia/src/features/create_group/domain/usecases/create-group-usecase.dart';
import 'package:njadia/src/features/create_group/domain/usecases/delete-admin-usecase.dart';
import 'package:njadia/src/features/create_group/domain/usecases/delete-member-usecase.dart';
import 'package:njadia/src/features/create_group/domain/usecases/get-admins-usecase.dart';
import 'package:njadia/src/features/create_group/domain/usecases/get-members-usecase.dart';


import 'group-event.dart';
import 'group-state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupUsecase? groupUsecase;
  final GetGroupAdminUsecase? getGroupAdminUsecase; 
  final GetGroupMemberUsecase? getGroupMemberUsecase;

  final AddGroupAdminUsecase? addGroupAdminUsecase;
  final AddGroupMemberUsecase? addGroupMemberUsecase;

  final DeleteGroupAdminUsecase? deleteGroupAdminUsecase;
  final DeleteGroupMembernUsecase? deleteGroupMembernUsecase;
  
  GroupBloc({
    this.groupUsecase, 
    this.getGroupAdminUsecase, 
    this.getGroupMemberUsecase, 
    this.addGroupAdminUsecase, 
    this.addGroupMemberUsecase, 
    this.deleteGroupAdminUsecase, 
    this.deleteGroupMembernUsecase}) : super(GroupEmpty()) {
   


    on<OnCreateGroup>((event, emit) async{
  
        try {
          final response = await groupUsecase!.execute(event.groupEntity);
          response.fold((left)=>emit(Error()), (data)=>emit(GroupCreated()));
        } catch (e) {
          
            }
        });



       on<OnGetGroupAdmins>((event, emit) async{
        // try {
        //   final response = await getGroupAdminUsecase!.call(event.groupId);
        //   response.fold((left)=>OnError(), (data)=>OnGroupAdminsLoaded(groupAdmins: data));
        // } catch (e) {
          
        //     }
        });


       on<OnGetGroupMembers>((event, emit) async{
  
        // try {
        //   final response = await groupUsecase.execute(event.groupEntity);
        //   response.fold((left)=>OnError(), (data)=>OnGroupCreated());
        // } catch (e) {
          
        //     }
        });


         on<OnAddGroupMember>((event, emit) async{
  
        // try {
        //   final response = await groupUsecase.execute(event.groupEntity);
        //   response.fold((left)=>OnError(), (data)=>OnGroupCreated());
        // } catch (e) {
          
        //     }
        });

         on<OnAddroupAdmin>((event, emit) async{
  
        // try {
        //   final response = await groupUsecase.execute(event.groupEntity);
        //   response.fold((left)=>OnError(), (data)=>OnGroupCreated());
        // } catch (e) {
          
        //     }
        });
        
         on<OnDeleteGroupAdmin>((event, emit) async{
  
        // try {
        //   final response = await groupUsecase.execute(event.groupEntity);
        //   response.fold((left)=>OnError(), (data)=>OnGroupCreated());
        // } catch (e) {
          
        //     }
        });


         on<OnDeleteGroupMember>((event, emit) async{
  
        // try {
        //   final response = await groupUsecase.execute(event.groupEntity);
        //   response.fold((left)=>OnError(), (data)=>OnGroupCreated());
        // } catch (e) {
          
        //     }
        });
  }
}


