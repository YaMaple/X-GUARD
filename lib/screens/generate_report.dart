import 'dart:typed_data';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'dart:async';

import 'package:pdf/widgets.dart' as pw;

FutureOr<Uint8List> buildPdf(PdfPageFormat format) async {
  const tableHeaders = ['Category', 'Budget', 'Expense', 'Result'];

  const dataTable = [
    ['ROA', 80, 30],
    ['Asset Turnover', 70, 40],
    ['Leverage Ratio', 60, 12],
    ['Liquidity Ratio', 30, 60],
    ['Current Ratio', 45, 70],
    ['Quick Ratio', 88, 28],
  ];

  final baseColor = PdfColors.cyan;

  // Create a PDF document.
  final document = pw.Document();

  final theme = pw.ThemeData.withFont(
    base: await PdfGoogleFonts.openSansRegular(),
    bold: await PdfGoogleFonts.openSansBold(),
  );

  // Top bar chart
  final chart1 = pw.Chart(
    title: pw.Text('Related financial ratios'),
    left: pw.Container(
      alignment: pw.Alignment.topCenter,
      // margin: const pw.EdgeInsets.only(right: 5, top: 10),
      child: pw.Transform.rotateBox(
        angle: pi / 2,
        child: pw.Text('Ratios', style: pw.TextStyle(fontSize: 10)),
      ),
    ),
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis.fromStrings(
          List<String>.generate(
              dataTable.length, (index) => dataTable[index][0] as String),
          marginStart: 30,
          marginEnd: 30,
          ticks: true,
          textStyle: pw.TextStyle(fontSize: 7)),
      yAxis: pw.FixedAxis(
        [0, 20, 40, 60, 80, 100],
        format: (v) => '%$v',
        divisions: true,
      ),
    ),
    datasets: [
      pw.BarDataSet(
        color: PdfColors.amber100,
        legend: tableHeaders[1],
        width: 15,
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
    title: pw.Text('Default Probability Trend'),
    bottom: pw.ChartLegend(direction: pw.Axis.horizontal),
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis([0, 1, 2, 3, 4, 5],
          textStyle: pw.TextStyle(fontSize: 10)),
      yAxis: pw.FixedAxis(
        [0, 20, 40, 60, 80, 100],
        textStyle: pw.TextStyle(fontSize: 10),
        divisions: true,
      ),
    ),
    datasets: [
      pw.LineDataSet(
        legend: 'Default Probability Trend',
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
      pw.LineDataSet(
        legend: 'Company Industrial Average',
        drawSurface: true,
        isCurved: true,
        drawPoints: false,
        color: PdfColors.amber300,
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

  // Add page to the PDF
  document.addPage(
    pw.Page(
      pageFormat: format,
      theme: theme,
      build: (context) {
        // Page layout
        return pw.Column(
          children: [
            pw.Text('Default Risk Report',
                style: pw.TextStyle(
                  color: baseColor,
                  fontSize: 40,
                )),
            pw.Divider(thickness: 4),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Expanded(
                  flex: 7,
                  child: pw.Column(children: [
                    // Expense by sub-categories
                    // 左列标题
                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      padding: const pw.EdgeInsets.only(bottom: 10),
                      child: pw.Text(
                        'General Comments',
                        style: pw.TextStyle(
                          color: baseColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Expense by sub-categories
                    // 左列正文
                    pw.Text(
                      '''[Sample Name]dosen''t have default history. Since the settlement of this loan,[Sample Name] has been paying loan in time periodically.
[Sample Name]has once default in [DD/MM/YY],the default amount was [? thousand HKD]. Since the settlement of this loan,[Sample Name] has been paying back loan in time periodically./[Sample Name] has the record of non-payment overdue.''',
                      textAlign: pw.TextAlign.justify,
                    ),
                    pw.ConstrainedBox(
                        constraints: pw.BoxConstraints(maxHeight: 100),
                        child: chart1),
                    pw.ConstrainedBox(
                        constraints: pw.BoxConstraints(maxHeight: 150),
                        child: chart2),
                  ])),
              pw.SizedBox(width: 10),
              pw.Expanded(
                  flex: 3,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Basic info:"),
                        pw.Text("Company:"),
                        pw.Text("LoanType:"),
                        pw.Text("Settlement:"),
                        pw.Text("maturity:"),
                        pw.Text("Bank:"),
                        pw.Text("Manager:"),
                        pw.Text("Amount:"),
                        pw.Text("Interest rate:"),
                        pw.Table.fromTextArray(
                            defaultColumnWidth: pw.FlexColumnWidth(1),
                            cellHeight: 10,
                            headerCount: 0,
                            context: context,
                            cellAlignment: pw.Alignment.center,
                            data: const <List<String>>[
                              <String>[
                                'Risk Indicator',
                                'Performance',
                              ],
                              <String>['Industry', 'XXXX'],
                            ]),
                        pw.Row(children: [
                          pw.Expanded(
                              child: pw.Table.fromTextArray(
                                  headerCount: 0,
                                  context: context,
                                  cellHeight: 67,
                                  cellAlignment: pw.Alignment.center,
                                  data: const <List<String>>[
                                <String>[
                                  'Operating Condition',
                                ],
                              ])),
                          pw.Expanded(
                              child: pw.Table.fromTextArray(
                                  context: context,
                                  headerCount: 0,
                                  cellHeight: 10,
                                  defaultColumnWidth: pw.FlexColumnWidth(1),
                                  cellAlignment: pw.Alignment.center,
                                  cellStyle: pw.TextStyle(fontSize: 5),
                                  data: const <List<String>>[
                                <String>['Health', '9'],
                                <String>['Profit', '6'],
                                <String>['Safety', '5'],
                                <String>['performance', '7'],
                              ])),
                        ]),
                        pw.Table.fromTextArray(
                            defaultColumnWidth: pw.FlexColumnWidth(1),
                            cellHeight: 10,
                            headerCount: 0,
                            context: context,
                            cellAlignment: pw.Alignment.center,
                            data: const <List<String>>[
                              <String>[
                                'Legal Condition',
                                'one contract',
                              ],
                              <String>['company', 'no relation change'],
                              <String>['credit', '9']
                            ]),
                      ]))
            ]),
            pw.Divider(),
            // 波形图
            pw.SizedBox(height: 10),
          ],
        );
      },
    ),
  );

  // Return the PDF file content
  return document.save();
}
