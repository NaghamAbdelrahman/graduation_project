import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zq/reusable/reuseable_component.dart';

import 'camscanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 50,
          child: ElevatedButton(
            child: const Text(
              "Connect",
              style: TextStyle(fontSize: 40),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff3D77BB))),
            onPressed: () async {
              Socket socket = await Socket.connect('192.168.1.1', 8080);
              print('connected');
              // listen to the received data event stream
              socket?.listen((List<int> event) {
                print(utf8.decode(event));
              });
              socket?.add(utf8.encode('${userEmail}'));
              socket?.add(utf8.encode('${userName}'));
              // .. and close the socket
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CamScanner()));
            },
          ),
        ),
      ),
    );
  }
}
