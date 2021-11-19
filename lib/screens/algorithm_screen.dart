import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'generate_report.dart';

import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:printing/printing.dart';

const gridColor = Color(0xff68739f);
const titleColor = Color(0xff8c95db);
const fashionColor = Color(0xffe15665);
const artColor = Color(0xff63e7e5);
const boxingColor = Color(0xff83dea7);
const entertainmentColor = Colors.white70;
const offRoadColor = Color(0xFFFFF59D);

List<RawDataSet> company_backup = [
  RawDataSet(
    title: 'Meta',
    network_id: '27105',
    imageUrl: 'assets/images/Meta.png',
    color: fashionColor,
    values: [300, 50, 250, 130, 100, 210],
  ),
  RawDataSet(
    title: 'LinkedIn',
    network_id: '27107',
    imageUrl: 'assets/images/LinkedIn.png',
    color: artColor,
    values: [250, 100, 200, 80, 270, 230],
  ),
  RawDataSet(
      title: 'Microsoft',
      network_id: '27200',
      color: boxingColor,
      values: [130, 120, 40, 230, 80, 190],
      imageUrl: 'assets/images/Microsoft.png'),
  RawDataSet(
      title: 'Amazon',
      network_id: '27202',
      color: gridColor,
      values: [110, 120, 80, 90, 220, 210],
      imageUrl: 'assets/images/Amazon.png')
];

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;
  final String imageUrl;
  final String network_id;

  RawDataSet(
      {required this.title,
      required this.color,
      required this.values,
      required this.imageUrl,
      required this.network_id});
}

class AlgorithmScreen extends StatefulWidget {
  static const routeName = '/algorithm';
  AlgorithmScreen();

  @override
  AlgorithmScreenState createState() => AlgorithmScreenState();
}

class AlgorithmScreenState extends State<AlgorithmScreen> {
  int selectedDataSetIndex = -1;

  String roa = "",
      liab_ratio = "",
      subsidiary = "",
      sales_profit = "",
      liquidity = "",
      secure_liab = "";

  List<RadarDataSet> showingDataSets() {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return company_backup
        .sublist(index, index + 1)
        .asMap()
        .entries
        .map((entry) {
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

  void get_company_info(int index) async {
    final para = {'id': company_backup[index].network_id};
    final uri = Uri.http('ftec5510.herokuapp.com', '/company', para);
    final response = await http.get(uri);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    roa = extractedData['roa'];
    liab_ratio = extractedData['liab_ratio'];
    subsidiary = extractedData['subsidiary'];
    sales_profit = extractedData['sales_profit'];
    liquidity = extractedData['liquidity'];
    secure_liab = extractedData['secure_liab'];
  }

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
        appBar: AppBar(
          title: Text(company_backup[index].title),
          backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.print),
          tooltip: 'Print Report',
          onPressed: () {
            Printing.layoutPdf(
              // [onLayout] will be called multiple times
              // when the user changes the printer or printer settings
              onLayout: (PdfPageFormat format) {
                // Any valid Pdf document can be returned here as a list of int
                return buildPdf(PdfPageFormat(
                    210 * PdfPageFormat.mm, 297 * PdfPageFormat.mm,
                    marginAll: 3 * PdfPageFormat.mm));
              },
            );
          },
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image(
                    image: AssetImage(company_backup[index].imageUrl),
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            //TextButton(onPressed: submitData, child: Text('TextButton')),
            Text(
              'Risk Radar',
              style: TextStyle(fontSize: 20),
            ),
            AspectRatio(
                aspectRatio: 1.0,
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
                    tickCount: 7,
                    ticksTextStyle:
                        const TextStyle(color: Colors.black, fontSize: 12),
                    tickBorderData: const BorderSide(color: Colors.black),
                    gridBorderData:
                        const BorderSide(color: gridColor, width: 2),
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 400),
                )),
          ],
        ));
  }
}
