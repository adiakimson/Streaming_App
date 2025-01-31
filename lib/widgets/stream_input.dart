import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:streaming_app/services/ip_service.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class StreamInput extends StatefulWidget {
  const StreamInput({super.key});

  @override
  _StreamInputState createState() => _StreamInputState();
}

class _StreamInputState extends State<StreamInput> {
  final IpService _ipService = IpService();
  final TextEditingController _rtmpController = TextEditingController(text: 'rtmp://');
  final TextEditingController _srtController = TextEditingController(text: 'srt://');
  VlcPlayerController? _vlcPlayerController;
  String? _publicIp;
  String? _localIp;

  @override
  void initState() {
    super.initState();
    _fetchIps();
  }

  void _fetchIps() async {
    try {
      final publicIp = await _ipService.getPublicIp();
      final localIp = await _ipService.getLocalIp();
      setState(() {
        _publicIp = publicIp;
        _localIp = localIp;
      });
    } catch (e) {
      setState(() {
        _publicIp = 'Failed to get public IP';
        _localIp = 'Failed to get local IP';
      });
    }
  }

  void _startServer(String url) {
    setState(() {
      _vlcPlayerController = VlcPlayerController.network(
        url,
        hwAcc: HwAcc.full,
        autoPlay: true,
      );
    });
  }

  void _stopServer() {
    _vlcPlayerController?.stop();
    _vlcPlayerController?.dispose();
    setState(() {
      _vlcPlayerController = null;
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

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
            if (_publicIp != null)
              Row(
                children: [
                  Text('Public IP: $_publicIp'),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(_publicIp!),
                  ),
                ],
              ),
            if (_localIp != null)
              Row(
                children: [
                  Text('Local IP: $_localIp'),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () => _copyToClipboard(_localIp!),
                  ),
                ],
              ),
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
                  onPressed: () => _startServer(_rtmpController.text),
                  child: Text('Start RTMP Server'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopServer,
                  child: Text('Stop RTMP Server'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _startServer(_srtController.text),
                  child: Text('Start SRT Server'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopServer,
                  child: Text('Stop SRT Server'),
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