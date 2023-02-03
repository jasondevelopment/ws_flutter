import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ws_flutter/ws_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UI展示"),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  CenterDialog.showCenterNoTitleDialog(
                      context, '已达本月提现次数上限，无法提现', '确定');
                },
                child: const Text('中间无标题单按钮弹窗')),
            TextButton(
                onPressed: () {
                  CenterDialog.showCenterDialog(
                      context, '退出登录', '是否确定退出登录？', '确定', '取消',
                          (positiveOrNegative) {
                           String message= (positiveOrNegative as bool) == false
                                ? '取消退出'
                                : '确定退出';

                        Fluttertoast.showToast(msg: message);
                      });
                },
                child: const Text('中间有标题双按钮弹窗')),
            TextButton(
                onPressed: () {
                  CenterInputDialog.showCenterInputDialog(
                      context, '留言', '留言区域。默认高度，可展示100字。可输入300字', '留言', '取消',
                          (inputContent) {
                        String message = inputContent as String;
                        if (message.isNotEmpty) {
                          Fluttertoast.showToast(msg: message);
                        }
                      });
                },
                child: const Text('中间输入弹窗')),
            TextButton(
                onPressed: () {
                  TakePhotoDialog.showTakePhotoDialog(context,
                          (takeCameraOrChooseAlbum) {
                            String message= (takeCameraOrChooseAlbum as bool) == true
                                ? '拍照'
                                : '从相册中选择';
                            Fluttertoast.showToast(msg: message);
                      });
                },
                child: const Text('底部拍照弹窗')),
            TextButton(
                onPressed: () {
                  List<String> menuTextList = [
                    '群众',
                    '共青团员',
                    '预备党员',
                    '共产党员',
                    '哈哈哈哈',
                    '哈哈哈哈哈'
                  ];
                  BottomMenuDialog.showDialog(context, '政治面貌', menuTextList,
                          (index) {
                            String message= '点击菜单条目$index';
                            Fluttertoast.showToast(msg: message);
                      });
                },
                child: const Text('底部滚动菜单')),
            TextButton(
                onPressed: () {
                  BottomPickerDateDialog.showDialog(context, null, 0, 3000,(dateString){
                    Fluttertoast.showToast(msg: dateString);
                  });
                },
                child: const Text('底部选择日期时间弹窗'))
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
