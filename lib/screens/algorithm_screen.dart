import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:convert';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

import 'package:http/http.dart' as http;

class AlgorithmScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  AlgorithmScreen(this.favoriteMeals);

  @override
  AlgorithmScreenState createState() => AlgorithmScreenState();
}

class AlgorithmScreenState extends State<AlgorithmScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  Future<void> submitData() async {
    print("submit data");
    print(titleController.text);
    print(amountController.text);

    final para = {
      'a1': 'one',
      'a2': 'two',
    };

    final uri = Uri.https('httpbin.org', '/anything', para);
    final response = await http.get(uri);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    print(extractedData['headers']['Accept']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                onSubmitted: (_) => submitData(),
              ),
            ],
          ),
        ));
  }
}
