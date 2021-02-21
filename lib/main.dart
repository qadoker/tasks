import 'package:flutter/material.dart';
import 'package:tasks_fonibo/tasks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}