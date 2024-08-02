


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/approve-usecase.dart';
import 'approval-event.dart';
import 'approval-state.dart';

class ApprovalBloc extends Bloc<ApprovalEvent, ApprovalState>{

  final ApprovalsUseCase approvalsUseCase;
  ApprovalBloc({required this.approvalsUseCase}):super(EmptyApprovals()){


    on<OnFetchApprovals>((event, emit) async{
        emit(ApprovalsLoading());
        final result =await approvalsUseCase.getPendingRequest(groupId: event.groupId);
        result.fold((l)=>emit(ApprovalError(error: "Error Fetching  request")), (data)=>data.isNotEmpty?emit(ApprovalsLoadded(approvals: data)):emit(EmptyApprovals()));
    });


     on<OnApprove>((event, emit)async{
           emit(ApprovalsLoading());
        final result = await approvalsUseCase.approvePendingRequest(groupId: event.groupId, userId: event.userId);
        result.fold((l)=>emit(ApprovalError(error: "Error Fetching request")), (data)=>emit(ApprovedRequest(status: data)));
    });


   on<OnReject>((event, emit)async{
         emit(ApprovalsLoading());

         final result = await approvalsUseCase.rejectPendingRequest(groupId: event.groupId, userId: event.userId);
        result.fold((l)=>emit(ApprovalError(error: "Error Fetching request")), (data)=>emit(RejectApproval(status: data)));
    });



  }
}