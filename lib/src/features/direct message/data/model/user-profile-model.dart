

import 'package:njadia/src/features/direct%20message/domain/entities/user-profile.dart';

class UserProfileModel extends UserProfile{
  final String uid;
  final String profile;
  final String firstName;
  final String lastName;

  UserProfileModel({ required this.uid, required this.profile, required this.firstName, required this.lastName}):super(uid:uid,profile:profile,firstName:firstName, lastName:lastName);
  
factory UserProfileModel.fromJson(Map<String, dynamic>json)=>UserProfileModel(uid: json["_id"], profile: json["selfie"], firstName: json["firstName"], lastName: json["lastName"]);
}