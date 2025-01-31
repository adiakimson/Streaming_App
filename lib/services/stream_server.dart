import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class StreamServer {
  late VlcPlayerController _controller;

  void startServer(String url) {
    _controller = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.full,
      autoPlay: true,
    );
  }

  void stopServer() {
    _controller.stop();
    _controller.dispose();
  }
}