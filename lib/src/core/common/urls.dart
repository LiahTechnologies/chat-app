class AppUrls {
  
  static const String BASEURL = "http://192.168.201.98:5000/api/";
  static const String SOCKET_URL ="http://192.168.201.98:5000";
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
  static const String fetchMessages = BASEURL+"messages/";
  static const String fetchGroupMessages = BASEURL+"messages/group";
  static const String sendMessage = BASEURL+"messages/send/";
  static const String sendGroupMessage = BASEURL+"messages/group/send/";
     static const String groupChatLastMessage = BASEURL+"messages/lastMessage";


  // Groups
  static const String groups = BASEURL+"groups";
  static const String groupAdmin = BASEURL+"groups/admins";
  static const String groupMembers = BASEURL+"groups/members/";
  static const String joinGroup = BASEURL+"groups/approval/";



  // User Groups and Chats
  static const String  userGroups = BASEURL+"user-chats/groups/";
   static const String userChats = BASEURL+"user-chats/chats/";
   static const String userChatList = BASEURL+"user-chats/";

    static const String uploadSignupFile = BASEURL+"files/signup-file";
    static const String uploadSinglFile = BASEURL+"files/upload-file";


  // Ballots
   static const String ballots = BASEURL+"groups/generate-ballots";
   static const String fetchBallots = BASEURL+"groups/fetch-ballots";
   

}
