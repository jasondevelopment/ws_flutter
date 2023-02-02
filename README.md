
<h1 align="center">WS_Flutter</h1>
<div align="center">

一套企业级移动端 Flutter 组件库

[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/jasondevelopment/ws_flutter/blob/main/LICENSE)

</div>

![](https://img.ljcdn.com/beike/zjz/bruno/img/1638883534391.png)

## ✨ 特性

- 提炼自企业级移动端产品的交互和视觉风格
- 开箱即用的高质量 Flutter 组件
- 设计工具赋能开发全链路

### Demo 下载


## 适配 Flutter 版本


| WS_Flutter 版本 | Flutter SDK 版本 |
|---------------| ---------------- |
| 3.2.0         | 3.3.0           |



## 接入

Flutter 工程中 pubspec.yaml 文件里加入以下依赖：

```dart
dependencies:
  ws_flutter: version
     
```

## 示例

```dart
import 'package:ws_flutter/ws_flutter.dart';
...
CenterDialog.showCenterDialog(
  context, '退出登录', '是否确定退出登录？', '确定', '取消',
    (positiveOrNegative) {
        if(positiveOrNegative){
          //确定
        } else{
          //取消
        } 
});
```

## 致谢

WS_Flutter 作为整套标准组件，参考和引用部分开源库如下：

- [flutter_gifimage](https://github.com/peng8350/flutter_gifimage)
- [expansion_tile_card.dart](https://gist.github.com/Skylled/7ac0f2f99881f7df2a0a850e60ef2df0)
- [photo_view](https://github.com/bluefireteam/photo_view)
- [flutter_intro](https://github.com/tal-tech/flutter_intro)
- [flutter_badges](https://github.com/yako-dev/flutter_badges)
- [lpinyin](https://github.com/flutterchina/lpinyin)
- [azlistview](https://github.com/flutterchina/azlistview)
- [flutter_path_drawing](https://github.com/dnfield/flutter_path_drawing)
- [bruno](https://github.com/LianjiaTech/bruno)


感谢以上开源库的团队及作者

