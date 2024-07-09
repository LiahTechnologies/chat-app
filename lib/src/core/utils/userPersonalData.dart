
import 'package:hive_flutter/hive_flutter.dart';
// 'userPersonalData.g.dart';
@HiveType(typeId: 1)
class UserPersonalData{
  @HiveField(0)
  String userId;

  @HiveField(1)
   String userName;

@HiveField(2)
   String profilePic;

UserPersonalData(this.profilePic, this.userId, this.userName);

  }
