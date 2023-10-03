import 'package:flutter/material.dart';
import 'package:webrtc_test/sender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
              title: TextButton(
            child: const Text("Sender"),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SenderScreen(),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
