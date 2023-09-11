import 'package:flutter/material.dart';
import 'package:masterapp/pages/homePages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.indigo),
      // theme: ThemeData(primaryColorDark: Color.fromARGB(161, 126, 47, 28)),
      home: Home(),
    );
  }
}
