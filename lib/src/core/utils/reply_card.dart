
import 'package:flutter/material.dart';

import '../entities/message_entity.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.messageEntity});
    final MessageEntity messageEntity;


  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-65,
        
      
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(15))),
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          color: Theme.of(context).colorScheme.tertiary,
          child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left:20.0,bottom: 20,right: 5, top: 5),
            child: Text("${messageEntity.message}",style: TextStyle(fontSize: 16),),
          ),
          Positioned(
            bottom: 4,
            right: 10,
            child: 
                Text("${messageEntity.dateTime}",style: TextStyle(fontSize: 11,color: Colors.grey[600]),),
              
          )
        ]),),
      ),
    );
  }
}