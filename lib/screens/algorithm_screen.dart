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
    imageUrl: 'assets/images/Meta.png',
    color: fashionColor,
    values: [300, 50, 250, 130, 100, 210],
  ),
  RawDataSet(
    title: 'LinkedIn',
    imageUrl: 'assets/images/LinkedIn.png',
    color: artColor,
    values: [250, 100, 200, 80, 270, 230],
  ),
  RawDataSet(
      title: 'Microsoft',
      color: boxingColor,
      values: [130, 120, 40, 230, 80, 190],
      imageUrl: 'assets/images/Microsoft.png'),
  RawDataSet(
      title: 'Amazon',
      color: gridColor,
      values: [110, 120, 80, 90, 220, 210],
      imageUrl: 'assets/images/Amazon.png')
];

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;
  final String imageUrl;

  RawDataSet(
      {required this.title,
      required this.color,
      required this.values,
      required this.imageUrl});
}

class AlgorithmScreen extends StatefulWidget {
  static const routeName = '/algorithm';
  AlgorithmScreen();

  @override
  AlgorithmScreenState createState() => AlgorithmScreenState();
}

class AlgorithmScreenState extends State<AlgorithmScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  int selectedDataSetIndex = -1;

  void submitData() async {
    print("submit data");
    print(titleController.text);
    print(amountController.text);

    // final para = {
    //   'name': 'TY',
    // };

    // final uri = Uri.http('ftec5510.herokuapp.com', '/user', para);
    // final response = await http.get(uri);
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // print(extractedData);
    // print(extractedData['headers']['Accept']);

    var url = Uri.parse('http://ftec5510.herokuapp.com/user');
    var response = await http.post(url, body: {
      'name': 'hjo',
      'email': 'cc@163.com',
      'password': '123456',
      'bank': 'EMO Bank',
      'field': 'tech'
    });
    print(response.statusCode);
    print(response.body);
  }

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
            TextButton(onPressed: submitData, child: Text('TextButton')),
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
