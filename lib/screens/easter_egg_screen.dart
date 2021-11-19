import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'without you ♥️',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 60,
              ),
              Text('HAN Tianyang',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text('YANG Jiaqi',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text('ZHANG Jiawei',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text('ZHANG Nian',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    print("test network");

                    final para = {
                      'id': '27105',
                    };

                    final uri =
                        Uri.http('ftec5510.herokuapp.com', '/company', para);
                    final response = await http.get(uri);
                    print("print response");
                    print(response);
                    print("print extractedData");
                    final extractedData =
                        json.decode(response.body) as Map<String, dynamic>;
                    print(extractedData);

                    // var url = Uri.parse('http://ftec5510.herokuapp.com/user');
                    // var response = await http.post(url, body: {
                    //   'name': 'hjo',
                    //   'email': 'cc@163.com',
                    //   'password': '123456',
                    //   'bank': 'EMO Bank',
                    //   'field': 'tech'
                    // });
                    // print(response.statusCode);
                    // print(response.body);
                  },
                  child: Text("Network Test"))
            ])));
  }
}
