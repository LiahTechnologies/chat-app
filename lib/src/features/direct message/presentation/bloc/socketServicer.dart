import 'package:njadia/src/core/common/urls.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PrivateSocketService {
  // late IO.Socket socket;
  PrivateSocketService();


 final socket = IO.io(AppUrls.sendGroupMessage, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });


  void connect(String groupId) {
    socket.connect();
    // socket.emit('join', groupId);
  }

  // void connect(String groupId) {
  //   socket = IO.io(url, <String, dynamic>{
  //     'transports': ['websocket'],
  //   });

  //   socket.on('connect', (_) {
  //     print('connected');
  //     socket.emit('joinGroup', groupId);
  //   });

  //   socket.on('disconnect', (_) => print('disconnected'));
  // }

  

  void onNewGroupMessage(Function(dynamic) callback) {
    socket.on('newGroupMessage', callback);
  }

  void disconnect(String groupId) {
    socket.emit('leaveGroup', groupId);
    socket.disconnect();
  }
}
