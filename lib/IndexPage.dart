import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool isLoading = false;
  var respBody = "";
  double? btc = 0.0;
  double? eth = 0.0;
  String uri = "https://api.coingecko.com/api/v3/global";
  Map<String, double?>? marketCapPercentage;

  @override
  void initState() {
    super.initState();
  }

  getData() async {
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    var respBody = jsonDecode(response.body);
    var data = respBody['data'];
    marketCapPercentage =
        Map<String, double>.from(data['market_cap_percentage']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'API Practice',
          ),
        ),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 50,
                      width: 175,
                      child: ElevatedButton(
                          onPressed: () async {
                            getData();
                          },
                          child: const Text('Parse'))),
                  SizedBox(
                      height: 50,
                      width: 175,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text('Show'))),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: getBody(),
              )
            ]))));
  }

  getBody() {
    double? btc = marketCapPercentage?['btc'];
    if (btc == null) {
      return Text('База данных пуста');
    } else {
      return Text('BTC=$btc');
    }
  }
}
