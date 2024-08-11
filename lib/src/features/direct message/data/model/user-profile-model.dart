

import 'package:hive_flutter/hive_flutter.dart';
import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';
part 'user-profile-model.g.dart';

@HiveType(typeId: 3)
class UserProfileModel extends UserProfile{
  @HiveField(1)
  final String uid;
  @HiveField(2)
  final String profile;
  @HiveField(3)
  final String firstName;
  @HiveField(4)
  final String lastName;

  UserProfileModel({ required this.uid, required this.profile, required this.firstName, required this.lastName}):super(uid:uid,profile:profile,firstName:firstName, lastName:lastName);
  
factory UserProfileModel.fromJson(Map<String, dynamic>json)=>UserProfileModel(uid: json["_id"], profile: json["selfie"], firstName: json["firstName"], lastName: json["lastName"]);
}