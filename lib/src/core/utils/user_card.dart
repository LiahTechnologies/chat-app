import 'package:flutter/material.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/entities/message_entity.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.messageEntity});
  final MessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 65,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: Theme.of(context).colorScheme.secondary,
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, bottom: 20, right: 35, top: 5),
              child: Text(
                "${messageEntity.message}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Positioned(
              bottom: 4,
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
            )
          ]),
        ),
      ),
    );
  }
}
