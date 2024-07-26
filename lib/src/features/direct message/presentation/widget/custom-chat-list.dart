import 'package:flutter/material.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';
import '../../../../core/common/constants/style/style.dart';


class CustomChatCard extends StatelessWidget {
  const CustomChatCard({super.key, required this.user, required this.onTap});
  final UserProfile user;
  
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap
        
      ,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 33,
              child: Icon(
                Icons.person,
                color: primaryWhite,
                size: 32,
              ),
              backgroundColor: Theme.of(context).iconTheme.color!.withOpacity(0.7),
            ),
            trailing: Text("12:00pm"),
            title: Text(
              "${user.firstName}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 5,
                ),
                Text(""),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
