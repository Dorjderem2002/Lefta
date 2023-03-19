import 'package:dimy/master.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lefta',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MasterPage(),
    );
  }
}
