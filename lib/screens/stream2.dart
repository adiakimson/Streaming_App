import 'package:flutter/material.dart';
import '../widgets/stream_monitor.dart';

class Stream2Page extends StatelessWidget {
  const Stream2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream 2'),
      ),
      body: const Center(
        child: StreamMonitor(streamId: 2),
      ),
    );
  }
}