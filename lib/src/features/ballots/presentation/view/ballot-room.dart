import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-bloc.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-event.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/common/helper_function.dart';
import '../../../../core/common/urls.dart';

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

  List<String>  ballotNumbers = [];
 late IO.Socket socket;
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    getBallot();
  }

  late HelperFunction helperFunction;
  
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
                  
                   
                  
                  
                const  SizedBox(height: 30,),
               
                  BlocBuilder<BallotBloc,BallotState>(
                    builder: (context,state) {

                    


                      if(state is BallotError)
                      Text("Tap on one of the bottons, an the number will be your ballot number",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),);

                      if(state is BallotError){
                        return Column(
                          children: [
                                                    Text("Your selected ballot number is:",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),),

                            Center(child: Text("$seletedNumber",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white)),),
                          ],
                        );
                      }
                     
                      if(state is BallotsLoaded){ 
                        // setState(() {
                          ballotNumbers= state.ballots;
                        // });
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

                              helperFunction=HelperFunction(groupBallot: widget.groupId);

                                final data={
                                  "groupId":widget.groupId,
                                  "uid":widget.uid,
                                  "value":seletedNumber
                                };
                              helperFunction.saveUserBallotNumber(seletedNumber);

                              socket.emit("selectballote",data);
                              }
                            
                            },child:seletedNumber=='-1'?Text(""): selectedIndex==index? Text("$seletedNumber"):Text(""),));}

                    return selectedIndex==-1?   Text("Loading...",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),):Center(child: Text(" $seletedNumber",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),));
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


 getBallot() async{
  seletedNumber = await  helperFunction.getUserBallotNumber();
   
}
void connect()  {
    print("THE CONNECTION IS BEING CALLED");
    socket = IO.io(AppUrls.SOCKET_URL, <String, dynamic>{
      "query":{
          "userId":widget.uid
      },
      'transports': ['websocket'],
      "autoConnect": false,



    });
    socket.connect();

    socket.on('connect', (_) {
      print('BALLOT USER CONNECTED');
    });

    socket.on("ballots",(data) async{
      
       setState(() {
         ballotNumbers= data;
       });
        
    });
   


    socket.on('disconnect', (_) {
      print('User disconnected');
    });
  }
  
  
}