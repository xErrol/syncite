import 'package:flutter/material.dart';
import 'view/googleBottomBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'synCITE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: GoogleBottomBar(), // Use GoogleBottomBar widget here
    );
  }
}
