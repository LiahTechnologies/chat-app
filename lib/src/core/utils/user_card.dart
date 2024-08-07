import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/style.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.messageEntity});
  final MessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {

    print("THIS IS THE MESSAGE $messageEntity");
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 165,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color:primaryGreen.withOpacity(0.7),
          child: Stack(children: [

/*
                  if(messageEntity.replyMessage.isNotEmpty)
                                              Positioned(
                                                top: 1,
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 8,bottom: 10),
                                                  height: 45,
                                                  width: MediaQuery.of(context).size.width - 100,
                                                 decoration: BoxDecoration(
                                                   color: Colors.grey[700]!.withOpacity(0.15),
                                                   borderRadius: BorderRadius.circular(15)
                                                 ),
                                                  child: Stack(
                                                    children: [


                                                      // Positioned(
                                                      //   top: -10,
                                                      //   right: -1,
                                                      //   child: IconButton(onPressed: (){
                                                      //       setState(() {
                                                      //         isReplyMessage=false;
                                                      //       });
                                                      //     }, icon: Icon(Icons.close)),),

                                                      
                                                      SizedBox(
                                                        height: 50,
                                                        child:
                                                        
                                                        
                                                         Row(
                                                          children: [
                                                              Container(
                                                                
                                                                margin: const EdgeInsets.only(right: 5,bottom: 8),
                                                        
                                                                                     width: 5,
                                                                                            height: 30,
                                                                                            
                                                                                            decoration: BoxDecoration(
                                                                                               color: Theme.of(context).appBarTheme.backgroundColor,
                                                                                               borderRadius: BorderRadius.only(
                                                                                               topLeft: Radius.circular(10),
                                                                                               bottomLeft: Radius.circular(10)
                                                                                               )
                                                                                                        
                                                                                            ),
                                                                                           ),
                                                                                            Expanded(
                                                                                              child: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                Text("${messageEntity.messageSender}",overflow:TextOverflow.ellipsis,maxLines: 1,),
                                                                                                Text("${messageEntity.message}",overflow:TextOverflow.ellipsis,maxLines: 1,)
                                                                                                  ],
                                                                                              ),
                                                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),*/

              if(messageEntity.replyMessage.isNotEmpty)
         

           
           Positioned(child: Padding(padding: EdgeInsets.only(left: 10, bottom: 10,top: 10),child: 

          
           
            Row(
              mainAxisSize: MainAxisSize.min,


                                                           children: [



                                                               Container(
                                                                 
                                                                 margin: const EdgeInsets.only(right: 5,bottom: 8),
                                                         
                                                                                      width: 5,
                                                                                             height: 30,
                                                                                             
                                                                                             decoration: BoxDecoration(
                                                                                                color: Theme.of(context).appBarTheme.backgroundColor,
                                                                                                borderRadius: BorderRadius.only(
                                                                                                topLeft: Radius.circular(10),
                                                                                                bottomLeft: Radius.circular(10)
                                                                                                )
                                                                                                         
                                                                                             ),
                                                                                            ),
                                                                                             Flexible(
                                                                                               child: Column(
                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                 children: [
                                                                                                 Text("${messageEntity.replySender}",overflow:TextOverflow.ellipsis,maxLines: 1,),
                                                                                                 Text("${messageEntity.replyMessage}",overflow:TextOverflow.ellipsis,maxLines: 1,)
                                                                                                   ],
                                                                                               ),
                                                                                             ),


                                                                                             
                                                           ],
                                                         )
           
           ,)
           
           ),
                                                  
            Positioned(
              // bottom: 4,
              child: Padding(
                padding:  EdgeInsets.only(
                    left: 10.0, bottom: 20, right: 5, top:messageEntity.replyMessage.isNotEmpty? 45:10),
                child: Text(
                  "${messageEntity.message}",
                  style:const TextStyle(fontSize: 16),
                ),
              ),
            ),


            Positioned(
              bottom: 8,
              right: 10,
              child: Row(
                children: [
                  Text(
                    "${messageEntity.dateTime}",
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.done_all,
                    size: 20,
                  )
                ],
              ),
            ),



            

          ]),
        ),
      ),
    );
  }
}
