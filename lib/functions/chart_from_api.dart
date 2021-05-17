import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SalesData> chartData = [];

  @override
  void initState() {
    loadSalesData();
    super.initState();
  }

  Future loadSalesData() async {
    String jsonString = await getJsonFromFirebaseRestAPI();
    final jsonResponse = json.decode(jsonString);
    setState(() {
      for (Map<String, dynamic> i in jsonResponse)
        chartData.add(SalesData.fromJson(i));
    });
  }

  Future<String> getJsonFromFirebaseRestAPI() async {
    var url = "https://exceptional-studios.herokuapp.com/api/graph-task";
    var response = await http.get(Uri.parse(url));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter chart'),
      ),
      body: Center(
          child: chartData.isNotEmpty
              ? Container(
                  height: 500,
                  width: 300,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Half yearly sales analysis'),
                      series: <ChartSeries<SalesData, int>>[
                        LineSeries<SalesData, int>(
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.xAxis,
                            yValueMapper: (SalesData sales, _) => sales.yAxis,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: false))
                      ]),
                )
              : Card(
                  elevation: 5.0,
                  child: Container(
                    height: 100,
                    width: 400,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Retriving Firebase data...',
                              style: TextStyle(fontSize: 20.0)),
                          Container(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              semanticsLabel: 'Retriving Firebase data',
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blueAccent),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
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
