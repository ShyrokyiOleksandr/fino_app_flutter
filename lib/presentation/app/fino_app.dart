import 'package:fino/presentation/features/main/main_screen.dart';
import 'package:flutter/material.dart';

class FinoApp extends StatelessWidget {
  const FinoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Cabin",
      ),
      home: const MainScreen(),
    );
  }
}