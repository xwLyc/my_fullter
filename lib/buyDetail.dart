import 'package:flutter/material.dart';

class BuyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '付款',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('付款详情页'),
      ),
    );
  }
}
