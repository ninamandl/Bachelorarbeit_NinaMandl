// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

// view
import 'package:speedometer_02/tacho.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instrument Panel',
      home: const Home(title: 'Instrument Panel',),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
        appBar: AppBar(
          title: Text("Instrument Panel - Testing"),
          backgroundColor: Color.fromARGB(255, 34, 34, 34),
        ),
        body:Container(
          child: Tacho(),
        ),
      );
  }
}
