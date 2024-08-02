// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/appAsset.dart';
import 'package:njadia/src/core/common/helper_function.dart';
import 'package:njadia/src/features/approve-tojoin-group/presentation/bloc/approval-event.dart';
import 'package:njadia/src/features/approve-tojoin-group/presentation/bloc/approval-state.dart';
import 'package:njadia/src/features/home/presentation/view/home.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../core/common/constants/style/color.dart';
import '../bloc/approval-bloc.dart';

class ApproveToJoin extends StatelessWidget {
  const ApproveToJoin({super.key, required this.groupId});
final String groupId;

  @override
  Widget build(BuildContext context) {
  context.read<ApprovalBloc>().add(OnFetchApprovals(groupId: groupId));

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackArrow(),
        centerTitle: true,
        title:const Text("Approve to Join"),

      ),
      body: BlocBuilder<ApprovalBloc,ApprovalState>(
        builder: (context,state) {
          if(state is ApprovalsLoading) {
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is ApprovalsLoadded)
          
          // ignore: curly_braces_in_flow_control_structures
          return ListView.builder(
            itemCount: state.approvals.length,
            itemBuilder: (context,index)=>ListTile(
            leading: CircleAvatar(
              child: Image.asset(AppImages.PERSON),
            
            ),
            title: Text("${state.approvals[index].firstName} ${state.approvals[index].lastName}"),
   
            trailing: 
    
            SizedBox(
              width: 100,
              child: Row(children: [
                    IconButton(onPressed: (){
                      
                      context.read<ApprovalBloc>().add(OnApprove(groupId: groupId, userId: state.approvals[index].uid));

                      nextScreen(context, HomePage());
                    }, icon: Icon(Icons.done,color: Theme.of(context).appBarTheme.backgroundColor,)),
              
                    IconButton(onPressed: (){
                      
                      context.read<ApprovalBloc>().add(OnReject(groupId: groupId, userId: state.approvals[index].uid));
                      
                      nextScreen(context, HomePage());
                      }, icon:const  Icon(Icons.close,color: Colors.red,)),
  
              ],),
            ),
          ));

          else if(state is ApprovalError)
           return const Center(child: Text("Error Fetching Result"),);


           else if(state is EmptyApprovals)
           return const Center(child: Text("No Approvals"),);

          else
          return const Center(child: Text("No Approvals"),);
        }
      )
      );
    
  }
  
}