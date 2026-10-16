import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  @override
  Widget build(BuildContext context) {
    print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location!!'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Text('location screen'),
    );
  }
}
