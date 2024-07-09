import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(String groupId) {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('connected');
      socket.emit('joinGroup', groupId);
    });

    socket.on('disconnect', (_) => print('disconnected'));
  }

  void onNewMessage(Function(dynamic) callback) {
    socket.on('newMessage', callback);
  }

  void disconnect(String groupId) {
    socket.emit('leaveGroup', groupId);
    socket.disconnect();
  }
}
