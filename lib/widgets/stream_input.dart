import 'package:flutter/material.dart';
import 'package:streaming_app/services/stream_server.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class StreamInput extends StatefulWidget {
  @override
  _StreamInputState createState() => _StreamInputState();
}

class _StreamInputState extends State<StreamInput> {
  final StreamServer _streamServer = StreamServer();
  final TextEditingController _rtmpController = TextEditingController();
  final TextEditingController _srtController = TextEditingController();
  VlcPlayerController? _vlcPlayerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Server'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _rtmpController,
              decoration: InputDecoration(
                labelText: 'RTMP URL',
              ),
            ),
            TextField(
              controller: _srtController,
              decoration: InputDecoration(
                labelText: 'SRT URL',
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _streamServer.startServer(_rtmpController.text);
                      _vlcPlayerController = VlcPlayerController.network(
                        _rtmpController.text,
                        hwAcc: HwAcc.full,
                        autoPlay: true,
                      );
                    });
                  },
                  child: Text('Start RTMP Server'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _streamServer.stopServer();
                    setState(() {
                      _vlcPlayerController = null;
                    });
                  },
                  child: Text('Stop RTMP Server'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_vlcPlayerController != null)
              Expanded(
                child: VlcPlayer(
                  controller: _vlcPlayerController!,
                  aspectRatio: 16 / 9,
                  placeholder: Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}