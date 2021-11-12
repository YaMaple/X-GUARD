import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/meal.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

const gridColor = Color(0xff68739f);
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

List<RawDataSet> rawDataSets() {
  return [
    RawDataSet(
      title: 'Amazon',
      color: fashionColor,
      values: [300, 50, 250, 130, 100, 210],
    ),
    RawDataSet(
      title: 'Google',
      color: artColor,
      values: [250, 100, 200, 80, 270, 230],
    ),
  ];
}

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}

class AlgorithmScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  AlgorithmScreen(this.favoriteMeals);

  @override
  AlgorithmScreenState createState() => AlgorithmScreenState();
}

class AlgorithmScreenState extends State<AlgorithmScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  int selectedDataSetIndex = -1;

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

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      var index = entry.key;
      var rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
        ),
        body: Column(
          children: <Widget>[
            Container(
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
            ),
            AspectRatio(
                aspectRatio: 1.3,
                child: RadarChart(
                  RadarChartData(
                    radarTouchData: RadarTouchData(
                        touchCallback: (FlTouchEvent event, response) {
                      if (!event.isInterestedForInteractions) {
                        setState(() {
                          selectedDataSetIndex = -1;
                        });
                        return;
                      }
                      setState(() {
                        selectedDataSetIndex =
                            response?.touchedSpot?.touchedDataSetIndex ?? -1;
                      });
                    }),
                    dataSets: showingDataSets(),
                    radarBackgroundColor: Colors.transparent,
                    borderData: FlBorderData(show: false),
                    radarBorderData: const BorderSide(
                        color: Color.fromARGB(0xff, 0x14, 0x27, 0x4e)),
                    titlePositionPercentageOffset: 0.2,
                    titleTextStyle:
                        const TextStyle(color: titleColor, fontSize: 14),
                    getTitle: (index) {
                      switch (index) {
                        case 0:
                          return 'Peer performance';
                        case 1:
                          return 'Cash flow';
                        case 2:
                          return 'Credit record';
                        case 3:
                          return 'Negative news';
                        case 4:
                          return 'Lawsuits';
                        case 5:
                          return 'Cash flow';
                        default:
                          return '';
                      }
                    },
                    tickCount: 1,
                    ticksTextStyle: const TextStyle(
                        color: Colors.transparent, fontSize: 10),
                    tickBorderData: const BorderSide(color: Colors.transparent),
                    gridBorderData:
                        const BorderSide(color: gridColor, width: 2),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 400),
                )),
          ],
        ));
  }
}
