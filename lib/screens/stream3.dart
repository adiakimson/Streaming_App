import 'package:flutter/material.dart';
import '../widgets/stream_monitor.dart';

class Stream3Page extends StatelessWidget {
  const Stream3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream 3'),
      ),
      body: const Center(
        child: StreamMonitor(streamId: 3),
      ),
    );
  }
}