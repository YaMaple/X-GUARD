import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';
import 'dart:async';

import 'package:pdf/widgets.dart' as pw;

import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';

import 'constants.dart';
import 'storage_info_card.dart';

class MyBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GroupedBarChart.withSampleData(),
    );
  }
}

class MyStackedAreaLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: StackedAreaLineChart.withSampleData(),
    );
  }
}

class MyDonutAutoLabelChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DonutAutoLabelChart.withSampleData(),
    );
  }
}

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {required this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart<Object>(List.from(seriesList),
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedAreaLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory StackedAreaLineChart.withSampleData() {
    return new StackedAreaLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(List.from(seriesList),
        defaultRenderer:
            new charts.LineRendererConfig(includeArea: true, stacked: true),
        animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];

    var myFakeTabletData = [
      new LinearSales(0, 10),
      new LinearSales(1, 50),
      new LinearSales(2, 200),
      new LinearSales(3, 150),
    ];

    var myFakeMobileData = [
      new LinearSales(0, 15),
      new LinearSales(1, 75),
      new LinearSales(2, 300),
      new LinearSales(3, 225),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeTabletData,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Mobile',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeMobileData,
      ),
    ];
  }
}

/// Bar chart example

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {required this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      List.from(seriesList),
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Storage Details",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: defaultPadding),
                MyBarChart(),
                MyDonutAutoLabelChart(),
                MyStackedAreaLineChart(),
                StorageInfoCard(
                  svgSrc: "assets/images/Documents.svg",
                  title: "Documents Files",
                  amountOfFiles: "1.3GB",
                  numOfFiles: 1328,
                ),
                StorageInfoCard(
                  svgSrc: "assets/images/media.svg",
                  title: "Media Files",
                  amountOfFiles: "15.3GB",
                  numOfFiles: 1328,
                ),
                StorageInfoCard(
                  svgSrc: "assets/images/folder.svg",
                  title: "Other Files",
                  amountOfFiles: "1.3GB",
                  numOfFiles: 1328,
                ),
                StorageInfoCard(
                  svgSrc: "assets/images/unknown.svg",
                  title: "Unknown",
                  amountOfFiles: "1.3GB",
                  numOfFiles: 140,
                ),
              ]),
        ));
  }
}

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FutureOr<Uint8List> buildPdf(PdfPageFormat format) async {
      const tableHeaders = ['Category', 'Budget', 'Expense', 'Result'];

      const dataTable = [
        ['Phone', 80, 95],
        ['Internet', 250, 230],
        ['Electricity', 300, 375],
        ['Movies', 85, 80],
        ['Food', 300, 350],
        ['Fuel', 650, 550],
        ['Insurance', 250, 310],
      ];

      // Some summary maths
      final budget = dataTable
          .map((e) => e[1] as num)
          .reduce((value, element) => value + element);
      final expense = dataTable
          .map((e) => e[2] as num)
          .reduce((value, element) => value + element);

      final baseColor = PdfColors.cyan;

      // Create a PDF document.
      final document = pw.Document();

      final theme = pw.ThemeData.withFont(
        base: await PdfGoogleFonts.openSansRegular(),
        bold: await PdfGoogleFonts.openSansBold(),
      );

      // Top bar chart
      final chart1 = pw.Chart(
        left: pw.Container(
          alignment: pw.Alignment.topCenter,
          margin: const pw.EdgeInsets.only(right: 5, top: 10),
          child: pw.Transform.rotateBox(
            angle: pi / 2,
            child: pw.Text('Amount'),
          ),
        ),
        overlay: pw.ChartLegend(
          position: const pw.Alignment(-.7, 1),
          decoration: pw.BoxDecoration(
            color: PdfColors.white,
            border: pw.Border.all(
              color: PdfColors.black,
              width: .5,
            ),
          ),
        ),
        grid: pw.CartesianGrid(
          xAxis: pw.FixedAxis.fromStrings(
            List<String>.generate(
                dataTable.length, (index) => dataTable[index][0] as String),
            marginStart: 30,
            marginEnd: 30,
            ticks: true,
          ),
          yAxis: pw.FixedAxis(
            [0, 100, 200, 300, 400, 500, 600, 700],
            format: (v) => '\$$v',
            divisions: true,
          ),
        ),
        datasets: [
          pw.BarDataSet(
            color: PdfColors.blue100,
            legend: tableHeaders[2],
            width: 15,
            offset: -10,
            borderColor: baseColor,
            data: List<pw.LineChartValue>.generate(
              dataTable.length,
              (i) {
                final v = dataTable[i][2] as num;
                return pw.LineChartValue(i.toDouble(), v.toDouble());
              },
            ),
          ),
          pw.BarDataSet(
            color: PdfColors.amber100,
            legend: tableHeaders[1],
            width: 15,
            offset: 10,
            borderColor: PdfColors.amber,
            data: List<pw.LineChartValue>.generate(
              dataTable.length,
              (i) {
                final v = dataTable[i][1] as num;
                return pw.LineChartValue(i.toDouble(), v.toDouble());
              },
            ),
          ),
        ],
      );

      // Left curved line chart
      final chart2 = pw.Chart(
        right: pw.ChartLegend(),
        grid: pw.CartesianGrid(
          xAxis: pw.FixedAxis([0, 1, 2, 3, 4, 5, 6]),
          yAxis: pw.FixedAxis(
            [0, 200, 400, 600],
            divisions: true,
          ),
        ),
        datasets: [
          pw.LineDataSet(
            legend: 'Expense',
            drawSurface: true,
            isCurved: true,
            drawPoints: false,
            color: baseColor,
            data: List<pw.LineChartValue>.generate(
              dataTable.length,
              (i) {
                final v = dataTable[i][2] as num;
                return pw.LineChartValue(i.toDouble(), v.toDouble());
              },
            ),
          ),
        ],
      );

      // Data table
      final table = pw.Table.fromTextArray(
        border: null,
        headers: tableHeaders,
        data: List<List<dynamic>>.generate(
          dataTable.length,
          (index) => <dynamic>[
            dataTable[index][0],
            dataTable[index][1],
            dataTable[index][2],
            (dataTable[index][1] as num) - (dataTable[index][2] as num),
          ],
        ),
        headerStyle: pw.TextStyle(
          color: PdfColors.white,
          fontWeight: pw.FontWeight.bold,
        ),
        headerDecoration: pw.BoxDecoration(
          color: baseColor,
        ),
        rowDecoration: pw.BoxDecoration(
          border: pw.Border(
            bottom: pw.BorderSide(
              color: baseColor,
              width: .5,
            ),
          ),
        ),
        cellAlignment: pw.Alignment.centerRight,
        cellAlignments: {0: pw.Alignment.centerLeft},
      );

      // Add page to the PDF
      document.addPage(
        pw.Page(
          pageFormat: format,
          theme: theme,
          build: (context) {
            // Page layout
            return pw.Column(
              children: [
                pw.Text('Budget Report',
                    style: pw.TextStyle(
                      color: baseColor,
                      fontSize: 40,
                    )),
                pw.Divider(thickness: 4),
                pw.Expanded(flex: 3, child: chart1),
                pw.Divider(),
                pw.Expanded(flex: 2, child: chart2),
                pw.SizedBox(height: 10),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                        child: pw.Column(children: [
                      pw.Container(
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.only(bottom: 10),
                        child: pw.Text(
                          'Expense By Sub-Categories',
                          style: pw.TextStyle(
                            color: baseColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      pw.Text(
                        'Total expenses are broken into different categories for closer look into where the money was spent.',
                        textAlign: pw.TextAlign.justify,
                      )
                    ])),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            padding: const pw.EdgeInsets.only(bottom: 10),
                            child: pw.Text(
                              'Spent vs. Saved',
                              style: pw.TextStyle(
                                color: baseColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          pw.Text(
                            'Budget was originally \$$budget. A total of \$$expense was spent on the month of January which exceeded the overall budget by \$${expense - budget}',
                            textAlign: pw.TextAlign.justify,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      // Second page with a pie chart
      document.addPage(
        pw.Page(
          pageFormat: format,
          theme: theme,
          build: (context) {
            const chartColors = [
              PdfColors.blue300,
              PdfColors.green300,
              PdfColors.amber300,
              PdfColors.pink300,
              PdfColors.cyan300,
              PdfColors.purple300,
              PdfColors.lime300,
            ];

            return pw.Column(
              children: [
                pw.Flexible(
                  child: pw.Chart(
                    title: pw.Text(
                      'Expense breakdown',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontSize: 20,
                      ),
                    ),
                    grid: pw.PieGrid(),
                    datasets:
                        List<pw.Dataset>.generate(dataTable.length, (index) {
                      final data = dataTable[index];
                      final color = chartColors[index % chartColors.length];
                      final value = (data[2] as num).toDouble();
                      final pct = (value / expense * 100).round();
                      return pw.PieDataSet(
                        legend: '${data[0]}\n$pct%',
                        value: value,
                        color: color,
                        legendStyle: const pw.TextStyle(fontSize: 10),
                      );
                    }),
                  ),
                ),
                table,
              ],
            );
          },
        ),
      );

      // Return the PDF file content
      return document.save();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('categories'),
        backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.print),
        tooltip: 'Print Document',
        onPressed: () {
          // This is where we print the document
          Printing.layoutPdf(
            // [onLayout] will be called multiple times
            // when the user changes the printer or printer settings
            onLayout: (PdfPageFormat format) {
              // Any valid Pdf document can be returned here as a list of int
              return buildPdf(format);
            },
          );
        },
      ),
      body: StarageDetails(),
    );
  }
}
