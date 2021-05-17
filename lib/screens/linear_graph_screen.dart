import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class LinearGraphScreen extends StatefulWidget {
  static const routeName = 'linear-graph-screnn';

  @override
  _LinearGraphScreenState createState() => _LinearGraphScreenState();
}

class _LinearGraphScreenState extends State<LinearGraphScreen> {
  List<SalesData> chartData = [];

  @override
  void initState() {
    // loadSalesData();
    super.initState();
  }

  Future loadSalesData() async {
    String jsonString = await getJsonFromFirebaseRestAPI();
    final jsonResponse = jsonDecode(jsonString);
    print(jsonResponse);
    setState(() {
      for (Map<String, dynamic> i in jsonResponse) {
        print(SalesData.fromJson(i));
        chartData.add(SalesData.fromJson(i));
      }
    });
  }

  Future<String> getJsonFromFirebaseRestAPI() async {
    var url = "https://exceptional-studios.herokuapp.com/api/graph-task";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: 400,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  chartData.isNotEmpty
                      ? SfCartesianChart(primaryXAxis: CategoryAxis(),
                          // Chart title
                          // title: ChartTitle(text: 'Half yearly sales analysis'),
                          series: <ChartSeries<SalesData, int>>[
                              LineSeries<SalesData, int>(
                                  dataSource: chartData,
                                  xValueMapper: (SalesData sales, _) =>
                                      sales.xAxis,
                                  yValueMapper: (SalesData sales, _) =>
                                      sales.yAxis,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: false))
                            ])
                      : Center(
                          child: Text(
                          'Show a linear graph \n Of your choice here ',
                          textAlign: TextAlign.center,
                        )),
                  // Center(
                  //     child: Text(
                  //   'Of your choice here',
                  //   textAlign: TextAlign.center,
                  // )),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 60.0,
                width: 210.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 8.0,
                      primary: Colors.green,
                      shadowColor: Colors.black),
                  onPressed: (() {
                    loadSalesData();
                  }),
                  child: Text(
                    'Data from api',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 28.0),
              child: Center(
                child: Container(
                  height: 60.0,
                  width: 210.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 8.0,
                        primary: Colors.black,
                        shadowColor: Colors.black),
                    onPressed: (() {loadSalesData();}),
                    child: Text(
                      'Show local data',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  int xAxis;
  int yAxis;

  SalesData({this.xAxis, this.yAxis});

  SalesData.fromJson(Map<String, dynamic> json) {
    xAxis = json['x_axis'];
    yAxis = json['y_axis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x_axis'] = this.xAxis;
    data['y_axis'] = this.yAxis;
    return data;
  }
}
