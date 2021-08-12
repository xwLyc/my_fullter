import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:my_flutter/services/networking.dart';
import 'package:my_flutter/utils/countDown.dart';
import 'package:my_flutter/buyDetail.dart';

HttpClient client = new HttpClient();

void main() => runApp(ExperienceApp());

// Scaffold 脚手架 定义了一个UI 框架，这个框架包含头部导航栏，body，Drawer,右下角浮动按钮，底部导航栏等
class ExperienceApp extends StatelessWidget {
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
  Map data = {
    'course_name': '',
    'cover_pic': '',
    'show_stock': '',
    'rest_stock': '',
    'year_sale_price_line': '',
    'coupon_after_price': '',
    'unit': '',
    'pic': []
  };
  Map _hms = {'h': '00', 'm': '00', 's': '00'};

  _getProductInfo() async {
    var url =
        'https://api-yf-monkey.xueersi.com/shop/api/v1/productInfo?spu_id=242759452053478700&form_type=1';
    var networkHelper = new NetworkHelper();

    var result = await networkHelper.getData(url);
    print('result: $result');

    if (!mounted) return;
    setState(() {
      if (result['code'] == 200) {
        data = result['data'];
        print('data is: $data');
      } else {
        print(result);
        return;
      }
    });
  }

  Timer? _timer;

  DateTime _time1 = new DateTime(2021, 04, 20, 22, 00);

  _countDown() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        DateTime _timenow = new DateTime.now();
        var diff = _time1.difference(_timenow);
        print('diff: $diff');
        _hms = CountDownutils.second2HMS(diff.inSeconds);
      });
    });
  }

  @override
  void initState() {
    _getProductInfo();
    _countDown();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 信息介绍行
    var show_stock = data['show_stock'];
    var rest_stock = data['rest_stock'];
    var year_sale_price_line = data['year_sale_price_line'];
    var coupon_after_price = data['coupon_after_price'];
    var unit = data['unit'];
    var bannerPic =
        data['banner_type'] == 1 ? data['head_url'][0] : data['cover_pic'];

    // obj.runtimeType.toString() 判断数据类型
    print('\nbanner_type ${bannerPic.runtimeType.toString()}');

    List? _list = data['pic'] ??= [];
    // print(_list);
    List _listPic = [];
    _list!.forEach((element) {
      List urlList = element['url'];
      urlList.forEach((pic) {
        _listPic.add(pic);
      });
    });
    print('\n图片数组：$_listPic');

    Widget infoDescSection = Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 16),
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            // color: Colors.indigoAccent,
            width: 10,
            style: BorderStyle.solid,
            color: Color.fromRGBO(250, 250, 250, 1),
          ),
        ),
      ),
      // color: Colors.white,
      width: double.maxFinite,
      // height: 200,
      // color: Colors.red[100],
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 100,
                child: Text(
                  data['course_name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(3, 0, 5, 0),
                child: Text(
                  '第69期',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: double.maxFinite,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    '限售$show_stock份，剩余$rest_stock份',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '04月19日开课',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '两周时间科学启蒙',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '￥',
                          style: TextStyle(
                            color: Colors.black38,
                            letterSpacing: -2,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          '$year_sale_price_line',
                          style: TextStyle(
                            color: Colors.black38,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Transform.translate(
                        offset: const Offset(0, 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                            ),
                            Text(
                              '￥',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red[500],
                                letterSpacing: -5,
                              ),
                            ),
                            Text(
                              '$coupon_after_price',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.red[500],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '$unit',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red[400],
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );

    Widget listPicSection = Column(
      children: [
        for (var url in _listPic) Image(image: NetworkImage(url, scale: 1.0)),
      ],
    );

    Widget bottomSection = DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          //阴影
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            offset: Offset(0, -2),
            blurRadius: 5.0,
          )
        ],
      ),
      child: Container(
        height: 80,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '距离停售还有',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                ),
                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 24,
                      color: Color.fromRGBO(244, 243, 243, .64),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                      child: Text(
                        '${_hms['h'].toString().split('')[0]}',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 18,
                      height: 24,
                      color: Color.fromRGBO(244, 243, 243, .64),
                      alignment: Alignment.center,
                      child: Text(
                        '${_hms['h'].toString().split('')[1]}',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 24,
                      alignment: Alignment.center,
                      child: Text(
                        '：',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 18,
                      height: 24,
                      color: Color.fromRGBO(244, 243, 243, .64),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                      child: Text(
                        '${_hms['m'].toString().split('')[0]}',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 18,
                      height: 24,
                      color: Color.fromRGBO(244, 243, 243, .64),
                      alignment: Alignment.center,
                      child: Text(
                        '${_hms['m'].toString().split('')[1]}',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 24,
                      alignment: Alignment.center,
                      child: Text(
                        '：',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 18,
                      height: 24,
                      color: Color.fromRGBO(244, 243, 243, .64),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                      child: Text(
                        '${_hms['s'].toString().split('')[0]}',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 18,
                      height: 24,
                      color: Color.fromRGBO(244, 243, 243, .64),
                      alignment: Alignment.center,
                      child: Text(
                        '${_hms['s'].toString().split('')[1]}',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return BuyDetail();
                  }),
                );
              },
              child: Text(
                '立即购买',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              minWidth: 150,
              height: 50,
              color: Colors.deepOrange[300],
              // splashColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '小猴语文体验课',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            // Text(jsonEncode(data)),
            if (bannerPic != '')
              Image(image: NetworkImage(bannerPic, scale: 1.0)),
            infoDescSection,
            listPicSection,
          ],
        ),
      ),
      // body: FutureBuilder(
      //   future: _getProductInfo(),
      //   builder: (context, snapshot) {
      //     return SafeArea(
      //       child: ListView(
      //         children: [
      //           Image(image: NetworkImage(data['cover_pic'], scale: 1.0)),
      //           infoDescSection,
      //           listPicSection,
      //         ],
      //       ),
      //     );
      //   },
      // ),

      bottomNavigationBar: SafeArea(
        child: bottomSection,
      ),
    );
  }
}
