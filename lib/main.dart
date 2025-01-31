import 'package:flutter/material.dart';
import 'package:streaming_app/widgets/stream_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streaming App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamInput(),
    );
  }
}