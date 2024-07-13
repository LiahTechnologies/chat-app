// import 'package:njadia/src/core/common/urls.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   // late IO.Socket socket;
//   final bool isGroup;
//   SocketService(this.isGroup,);

//   final group = AppUrls.sendGroupMessage;
//    final private = AppUrls.sendGroupMessage;

//  final socket = IO.io(isGroup?group:private, <String, dynamic>{
//     'transports': ['websocket'],
//     'autoConnect': false,
//   });


//   void connect(String groupId) {
//     socket.connect();
//     // socket.emit('join', groupId);
//   }

//   // void connect(String groupId) {
//   //   socket = IO.io(url, <String, dynamic>{
//   //     'transports': ['websocket'],
//   //   });

//   //   socket.on('connect', (_) {
//   //     print('connected');
//   //     socket.emit('joinGroup', groupId);
//   //   });

//   //   socket.on('disconnect', (_) => print('disconnected'));
//   // }

  // void onNewMessage(Function(dynamic) callback) {
  //   socket.on('newMessage', callback);
  // }

  // void onNewGroupMessage(Function(dynamic) callback) {
  //   socket.on('newGroupMessage', callback);
  // }

//   void disconnect(String groupId) {
//     socket.emit('leaveGroup', groupId);
//     socket.disconnect();
//   }
// }


import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final String serverUrl; // URL of your socket server
  final String currentUserId; // ID of the current user
 

  SocketService(this.serverUrl, this.currentUserId);


late IO.Socket _socket;

  void initSocket() {
    _socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    // Handle incoming messages
    _socket.on('message', (data) {
      // Process incoming message data
      // final message = Message.fromJson(data); // Implement your Message model
      // Handle the received message as needed
    });
  }

  // void sendMessage(String groupId, String message) {
  //   _socket.emit('sendMessage', {
  //     'groupId': groupId,
  //     'message': message,
  //     'senderId': currentUserId,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //   });
  // }


  void onNewMessage(Function(dynamic) callback) {
    _socket.on('newMessage', callback);
  }

  void onNewGroupMessage(Function(dynamic) callback) {
    _socket.on('newGroupMessage', callback);
  }
  void dispose() {
    _socket.disconnect();
  }
}
