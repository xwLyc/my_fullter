// 获取当前ip地址接口

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

HttpClient client = new HttpClient();

void main() => runApp(MyApp());

// Scaffold 脚手架 定义了一个UI 框架，这个框架包含头部导航栏，body，Drawer,右下角浮动按钮，底部导航栏等
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '小猴',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _ipAddress = 'Unknown';

  _getIPAddress() async {
    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        var data = jsonDecode(json);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }

    if (!mounted) return;
    setState(() {
      _ipAddress = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(
      height: 32.0,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your current Ip addresss is: '),
            Text('$_ipAddress.'),
            spacer,
            RaisedButton(
              onPressed: _getIPAddress,
              child: Text('Get Ip Address'),
            ),
          ],
        ),
      ),
    );
  }
}
