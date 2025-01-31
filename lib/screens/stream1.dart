import 'package:flutter/material.dart';
import '../widgets/stream_monitor.dart';

class Stream1Page extends StatelessWidget {
  const Stream1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream 1'),
      ),
      body: const Center(
        child: StreamMonitor(streamId: 1),
      ),
    );
  }
}