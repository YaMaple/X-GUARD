import 'package:flutter/material.dart';
import 'constants.dart';

import '../dummy_data.dart';

class EasterEggScreen extends StatelessWidget {
  static const routeName = '/easter_egg';

  EasterEggScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Acknowledgments'),
          backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
        ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'It is impossible to build this app',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 30),
              Text(
                'without my lovely teammates',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              Text('hhhh')
            ])));
  }
}
