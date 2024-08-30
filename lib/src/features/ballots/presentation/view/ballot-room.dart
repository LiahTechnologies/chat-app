import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-bloc.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-event.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-state.dart';

import '../../../../core/common/helper_function.dart';

class BallotRoom extends StatefulWidget {
  const BallotRoom({super.key,required this.groupId, required this.uid});

final String groupId;
final String uid;
  @override
  State<BallotRoom> createState() => _BallotRoomState();
}

class _BallotRoomState extends State<BallotRoom> {
 String seletedNumber ='-1';
 int selectedIndex = -1;

 final List<String>  ballotNumbers = ["2","4","1","3","5","7","11","20"];

 

  @override
  Widget build(BuildContext context) {


    final orientation = MediaQuery.of(context).orientation;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    context.read<BallotBloc>().add(OnFetchBallots(groupId: widget.groupId, uid: widget.uid));

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Ballot Room",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white)),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: Container(
              padding: EdgeInsets.only(left: 20,bottom: 15,right: 20, top: 15),
              constraints: BoxConstraints(
                minHeight: height/5
              ),
              decoration: BoxDecoration(
                color: AppColor.LightAppBarColor,
                borderRadius: BorderRadius.circular(15)
              ),
              width: width-50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                // const  SizedBox(height: 10,),
                    Text("Tap on one of the bottons, an the number will be your ballot number",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),),
                  
                  
                const  SizedBox(height: 30,),
               
                  BlocBuilder<BallotBloc,BallotState>(
                    builder: (context,state) {
                      if(state is BallotsLoaded)
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: ballotNumbers.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                            crossAxisCount: (orientation == Orientation.portrait) ? 4 : 5), itemBuilder: (context,index)=>FloatingActionButton(     elevation: 7 ,  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            onPressed: (){
                              if(seletedNumber!='-1'){
                               showSnackMessage(context, Colors.red, "You have already selected a number");
                      
                              }
                              else{
                      
                                    setState(() {
                                seletedNumber=ballotNumbers[index];
                                selectedIndex= index;
                              });
                              }
                            
                            },child:seletedNumber=='-1'?Text(""): selectedIndex==index? Text("$seletedNumber"):Text(""),));

                    return const Text("Loading...");
                    }
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}