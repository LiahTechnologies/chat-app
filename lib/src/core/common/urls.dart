class AppUrls {
  static const String BASEURL = "http://192.168.0.106:5000/api/";
  static const String signup_file    =   BASEURL+"signup_files";
  static const String signup_details =   BASEURL+"signup_details";
  static const String login =   BASEURL+"auth/login";
  static const String signup =   BASEURL+"auth/signup";
  static const String logout =   BASEURL+"auth/logout";
  

  // USers apis
  static const String USERS =   BASEURL+"users"; 

  static const String OTP =   BASEURL+"otp";
  static const String OTP_VERIFICATION =   BASEURL+"verify";
  // static const String 


  // Messages
  static const String fetchChats = BASEURL+"user-chats";
  static const String fetchMessages= BASEURL+"messages";
  static const String sendMessage = BASEURL+"messages";


  // Groups
  static const String createGroup = BASEURL+"groups";
  static const String groupAdmin = BASEURL+"groups/admins";
  static const String groupMembers = BASEURL+"groups/members";

}
