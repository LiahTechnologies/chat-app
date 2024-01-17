class UserEntity {
  final String ui;
  final String firstName;
  final String lasName;
  final String email;

  UserEntity(
      {required this.email,
      required this.firstName,
      required this.lasName,
      required this.ui});

  factory UserEntity.fromjson(Map<String, dynamic> json) {
    return UserEntity(
        email: json["email"],
        firstName: json["firstName"],
        lasName: json["lasName"],
        ui: json["ui"]);
  }
}
