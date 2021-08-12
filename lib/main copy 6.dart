import 'package:flutter/material.dart';
import 'package:my_flutter/experience.dart';
import 'package:my_flutter/buyDetail.dart';

void main() => runApp(
      new MaterialApp(
        title: 'flutter 标题',
        home: MyApp(),
        routes: {
          'experience': (BuildContext context) => new ExperienceApp(),
        },
      ),
    );

// Scaffold 脚手架 定义了一个UI 框架，这个框架包含头部导航栏，body，Drawer,右下角浮动按钮，底部导航栏等
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my title'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: RaisedButton(
          child: Text('体验课详情'),
          onPressed: () {
            Navigator.pushNamed(context, 'experience');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('已点击');
        },
        child: Text('点击'),
      ),
      drawer: Drawer(
        child: Center(
          child: Text('Drawer'),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     height: 50,
      //   ),
      // ),
      // bottomSheet: BottomSheet(onClosing: () {
      //   print("bottomSheet onClosing");
      // }, builder: (BuildContext context) {
      //   return Container(
      //     height: 50,
      //     width: 50,
      //     child: Image(
      //         image: NetworkImage(
      //             "http://c.hiphotos.baidu.com/image/pic/item/a8773912b31bb0516a13ec1d387adab44aede0d4.jpg")),
      //   );
      // }),
    );
  }
}
