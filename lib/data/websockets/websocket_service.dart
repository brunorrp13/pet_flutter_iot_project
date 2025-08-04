import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';

class WebSocketService {
  final WebSocketChannel _channel;
  final StreamController<String> _controller = StreamController.broadcast();

  WebSocketService(String url)
      : _channel = WebSocketChannel.connect(Uri.parse(url)) {
    _channel.stream.listen(
      (message) => _controller.add(message),
      onError: (error) => _controller.addError(error),
      onDone: () => _controller.close(),
    );
  }

  Stream<String> get messages => _controller.stream;

  void send(String message) => _channel.sink.add(message);

  void dispose() {
    _channel.sink.close();
    _controller.close();
  }
}
