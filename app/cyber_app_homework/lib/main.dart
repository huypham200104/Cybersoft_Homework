import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          width: 200,
          height: 200,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      )
    );
  }
  }
