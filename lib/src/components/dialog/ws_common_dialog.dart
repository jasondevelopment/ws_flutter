import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/ws_colors.dart';

//取消类型按钮的样式
final ButtonStyle _buttonOutlineStyle = ElevatedButton.styleFrom(
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: ColorsWS.blue,
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
  shape:
      RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(8)),
  side: const BorderSide(
    color: ColorsWS.blue,
  ),
);

//确认类型按钮的样式
final ButtonStyle _buttonElevatedStyle = ElevatedButton.styleFrom(
  elevation: 0,
  backgroundColor: ColorsWS.blue,
  foregroundColor: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
  shape:
      RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(8)),
);

//单按钮的样式
final ButtonStyle _singleButtonStyle = ElevatedButton.styleFrom(
  elevation: 0,
  backgroundColor: ColorsWS.blue,
  foregroundColor: Colors.white,
  fixedSize: const Size(160, 48),
  shape:
      RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(8)),
);

//相机按钮的样式
final ButtonStyle _cameraButtonStyle = TextButton.styleFrom(
  elevation: 0,
  // backgroundColor: Colors.white,
  // foregroundColor: Colors_WS.text333,
  shape:
      RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(0)),
  fixedSize: const Size(700, 56),
);

//dialog类型
const int dialog_type_normal = 0; //普通型dialog
const int dialog_type_input = 1; //输入型dialog

//构建底部按钮
Widget _buildBottomButton(
        BuildContext context,
        String positiveButtonText,
        String? negativeButtonText,
        ValueChanged<Object>? onButtonPressed,
        int type,
        TextEditingController? controller) =>
    Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //显示取消按钮
        if (negativeButtonText != null)
          OutlinedButton(
            onPressed: () {
              //普通弹窗取消按钮点击监听的回调
              if (onButtonPressed != null && type == dialog_type_normal) {
                onButtonPressed(false);
              }
              //输入弹窗取消按钮点击监听的回调
              if (onButtonPressed != null && type == dialog_type_input) {
                onButtonPressed('');
              }
              //关闭弹窗
              Navigator.pop(context);
            },
            style: _buttonOutlineStyle,
            child: Text(
              negativeButtonText,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        //不是单按钮，需要按钮间的间隔
        if (negativeButtonText != null)
          const SizedBox(
            width: 16,
          ),
        //双按钮样式显示配置
        if (negativeButtonText != null)
          ElevatedButton(
              onPressed: () {
                //普通弹窗确认按钮点击监听的回调
                if (onButtonPressed != null && type == dialog_type_normal) {
                  onButtonPressed(true);
                  Navigator.pop(context);
                }
                //输入弹窗确认按钮点击监听的回调
                if (onButtonPressed != null &&
                    type == dialog_type_input &&
                    controller!.text.isNotEmpty) {
                  onButtonPressed(controller.text);
                  Navigator.pop(context);
                }
              },
              style: _buttonElevatedStyle,
              child: Text(
                positiveButtonText,
                style: const TextStyle(fontSize: 18),
              )),
        //单按钮样式显示配置
        if (negativeButtonText == null)
          ElevatedButton(
              onPressed: () {
                if (onButtonPressed != null) onButtonPressed(true);
                Navigator.pop(context);
              },
              style: _singleButtonStyle,
              child: Text(positiveButtonText,
                  style: const TextStyle(fontSize: 18)))
      ],
    );

//构建底部弹窗按钮
Widget _buildBottomDialogButton(
    BuildContext context, VoidCallback onButtonPressed) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        //取消按钮
        Expanded(
            flex: 1,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  foregroundColor: ColorsWS.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(8)),
                  side: const BorderSide(
                    color: ColorsWS.blue,
                  ),
                ),
                child: const Text(
                  '取消',
                  style: TextStyle(fontSize: 18, color: ColorsWS.blue),
                ))),
        const SizedBox(
          width: 23,
        ),
        //确定按钮
        Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: onButtonPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8)),
                elevation: 0,
                backgroundColor: ColorsWS.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                '确定',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ))
      ],
    ),
  );
}

//中间通用弹窗
class CenterDialog extends StatelessWidget {
  final String message; //弹窗内容
  final String positiveButtonText; //确认按钮文字自定义
  final String? title; //弹窗标题
  final String? negativeButtonText; //取消按钮文字自定义
  final ValueChanged<Object>? onButtonPressed; //点击事件回调

  const CenterDialog(
      {Key? key,
      required this.message,
      required this.positiveButtonText,
      this.title,
      this.negativeButtonText,
      this.onButtonPressed})
      : super(key: key);

  static showCenterNoTitleDialog(
      BuildContext context, String message, String positiveButtonText) {
    showDialog(
        context: context,
        builder: (context) => CenterDialog(
            message: message, positiveButtonText: positiveButtonText));
  }

  static showCenterDialog(
      BuildContext context,
      String title,
      String message,
      String positiveButtonText,
      String negativeButtonText,
      ValueChanged<Object> onButtonPressed) {
    showDialog(
        context: context,
        builder: (context) => CenterDialog(
              title: title,
              message: message,
              positiveButtonText: positiveButtonText,
              negativeButtonText: negativeButtonText,
              onButtonPressed: onButtonPressed,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 38),
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //显示标题
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    color: ColorsWS.text333),
              ),
            if (title != null) const SizedBox(height: 32),
            //显示内容
            Text(
              message,
              style: const TextStyle(
                  fontSize: 16,
                  color: ColorsWS.text333,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 40,
            ),
            //显示底部按钮
            _buildBottomButton(context, positiveButtonText, negativeButtonText,
                onButtonPressed, dialog_type_normal, null)
          ],
        ),
      ),
    );
  }
}

//中间输入型弹窗
class CenterInputDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String positiveButtonText;
  final String negativeButtonText;
  final ValueChanged<Object> onButtonPressed;

  const CenterInputDialog(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.positiveButtonText,
      required this.negativeButtonText,
      required this.onButtonPressed})
      : super(key: key);

  static showCenterInputDialog(
      BuildContext context,
      String title,
      String hintText,
      String positiveButtonText,
      String negativeButtonText,
      ValueChanged<Object> onButtonPressed) {
    showDialog(
        context: context,
        builder: (context) => CenterInputDialog(
            title: title,
            hintText: hintText,
            positiveButtonText: positiveButtonText,
            negativeButtonText: negativeButtonText,
            onButtonPressed: onButtonPressed));
  }

  //构建输入框
  Widget _buildInput(TextEditingController controller, String hintText,
          FocusNode focusNode) =>
      Container(
        width: double.infinity,
        height: 155,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //设置圆角背景
        decoration: BoxDecoration(
            color: ColorsWS.backGround,
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          maxLines: null,
          maxLength: 300,
          decoration: InputDecoration(
              counterText: '',
              hintText: hintText,
              hintMaxLines: 100,
              border: InputBorder.none),
          style: const TextStyle(fontSize: 16, color: ColorsWS.text333),
        ),
      );

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    FocusNode focusNode = FocusNode();
    return Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            focusNode.unfocus();
          },
          child: Center(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 38),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //显示标题
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                      color: ColorsWS.text333),
                ),
                const SizedBox(
                  height: 16,
                ),
                //显示输入内容
                _buildInput(controller, hintText, focusNode),
                const SizedBox(
                  height: 24,
                ),
                //显示底部按钮
                _buildBottomButton(
                    context,
                    positiveButtonText,
                    negativeButtonText,
                    onButtonPressed,
                    dialog_type_input,
                    controller)
              ],
            ),
          )),
        ));
  }
}

//选择照片的弹窗
class TakePhotoDialog extends StatelessWidget {
  //点击拍照还是选择相片的回调
  final ValueChanged<bool> onButtonPressed;

  const TakePhotoDialog({Key? key, required this.onButtonPressed})
      : super(key: key);

  static showTakePhotoDialog(
      BuildContext context, ValueChanged<bool> onButtonPressed) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) =>
            TakePhotoDialog(onButtonPressed: onButtonPressed));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(),
          )),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(
                      onPressed: () {
                        onButtonPressed(true);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        fixedSize: const Size(700, 56),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(16),
                                topEnd: Radius.circular(16))),
                      ),
                      child: const Text(
                        '拍照',
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorsWS.text333,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      color: ColorsWS.line2,
                      height: 0.5,
                      child: null,
                    ),
                    TextButton(
                      onPressed: () {
                        onButtonPressed(false);
                        Navigator.pop(context);
                      },
                      style: _cameraButtonStyle,
                      child: const Text(
                        '从相册中选择',
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorsWS.text333,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      color: ColorsWS.line2,
                      height: 12,
                      child: null,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: _cameraButtonStyle,
                      child: const Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorsWS.text333,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

//底部菜单弹窗
class BottomMenuDialog extends StatefulWidget {
  final String title;
  final List<String> menuTextList;
  final ValueChanged<int> onButtonPressed;

  const BottomMenuDialog(
      {Key? key,
      required this.title,
      required this.menuTextList,
      required this.onButtonPressed})
      : super(key: key);

  static showDialog(BuildContext context, String title,
      List<String> menuTextList, ValueChanged<int> selectedItemIndex) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => BottomMenuDialog(
            title: title,
            menuTextList: menuTextList,
            onButtonPressed: selectedItemIndex));
  }

  @override
  State<BottomMenuDialog> createState() => _BottomMenuDialogState();
}

class _BottomMenuDialogState extends State<BottomMenuDialog>
    with WidgetsBindingObserver {
  late FixedExtentScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      int defShowIndex = 0;
      if (widget.menuTextList.length % 2 == 0) {
        defShowIndex = widget.menuTextList.length ~/ 2;
      } else {
        defShowIndex = (widget.menuTextList.length + 1) ~/ 2;
      }
      controller.jumpToItem(defShowIndex);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //构建菜单列表
  Widget _buildMenuList(
      List<String> itemData, ValueChanged<int> onSelectedIndex) {
    return CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 50,
        diameterRatio: 20,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: CupertinoColors.tertiarySystemFill,
          capEndEdge: false,
          capStartEdge: false,
        ),
        useMagnifier: true,
        magnification: 1.1,
        squeeze: 1.0,
        scrollController: controller,
        //选中条目的回调
        onSelectedItemChanged: (index) {
          onSelectedIndex(index);
        },
        children: itemData
            .map(
              (text) => Center(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: ColorsWS.blue),
                ),
              ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    //当前选中到条目
    int selectedIndex = 0;
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(),
          )),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //标题
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            color: ColorsWS.text333,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //菜单列表
                    SizedBox(
                      //列表最高高度为 6*45
                      height: (widget.menuTextList.length > 6
                              ? 6
                              : widget.menuTextList.length) *
                          45,
                      //构建列表并回调选中index
                      child: _buildMenuList(widget.menuTextList, (index) {
                        selectedIndex = index;
                      }),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //底部按钮
                    _buildBottomDialogButton(context, () {
                      widget.onButtonPressed(selectedIndex);
                      Navigator.pop(context);
                    }),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

//底部日期选择弹窗
class BottomPickerDateDialog extends StatefulWidget {
  final String? title;
  final int minYear;
  final int maxYear;
  final ValueChanged<String> onSelectedDateTime;

  const BottomPickerDateDialog(
      {Key? key,
      this.title = '选择日期',
      required this.minYear,
      required this.maxYear,
      required this.onSelectedDateTime})
      : super(key: key);

  @override
  State<BottomPickerDateDialog> createState() => _BottomPickerDateDialogState();

  static showDialog(BuildContext context, String? title, int minYear,
      int maxYear, ValueChanged<String> onSelectedDateTime) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => BottomPickerDateDialog(
            title: title,
            minYear: minYear,
            maxYear: maxYear,
            onSelectedDateTime: onSelectedDateTime));
  }
}

class _BottomPickerDateDialogState extends State<BottomPickerDateDialog>
    with WidgetsBindingObserver {
  //构建显示的年月日列表
  Widget _buildDateTimeList(
      List<String> dateList,
      FixedExtentScrollController controller,
      ValueChanged<int> onSelectedItem) {
    return CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 50,
        diameterRatio: 20,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: CupertinoColors.tertiarySystemFill,
          capEndEdge: false,
          capStartEdge: false,
        ),
        useMagnifier: true,
        magnification: 1.1,
        squeeze: 1.0,
        scrollController: controller,
        //选中条目的回调
        onSelectedItemChanged: (index) {
          onSelectedItem(index);
        },
        children: dateList
            .map(
              (text) => Center(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: ColorsWS.blue),
                ),
              ),
            )
            .toList());
  }

  //获取年的范围取值数据 minYear~maxYear  1900~2050
  List<String> _getYearData(int minYear, int maxYear) {
    List<String> yearList = [];
    minYear = minYear <= 0 ? 1900 : minYear;
    minYear = minYear > 2022 ? 2022 : minYear;
    maxYear = maxYear >= 2050 ? 2050 : maxYear;
    maxYear = maxYear <= 0 ? 2022 : maxYear;

    for (int i = minYear; i <= maxYear; i++) {
      String year = '$i年';
      yearList.add(year);
    }

    return yearList;
  }

  //获取月的数据
  List<String> _getMonthData() {
    List<String> monthList = [];
    for (int i = 1; i <= 12; i++) {
      String month = '$i月';
      monthList.add(month);
    }
    return monthList;
  }

  //选中月的列表条目index
  int selectMonthItem = 1;
  String year = '';
  String month = '';
  String day = '';
  int defYearIndex = 0;
  int defMonthIndex = 0;
  int defDayIndex = 0;

  //根据月份获取对应的天数
  List<String> _getDayData(int month) {
    List<String> dayList = [];
    int maxDay = 31;
    switch (month) {
      case 4:
      case 6:
      case 9:
      case 11:
        maxDay = 30;
        break;
      case 2:
        maxDay = 28;
        break;
    }

    for (int i = 1; i <= maxDay; i++) {
      String day = '$i日';
      dayList.add(day);
    }
    return dayList;
  }

  //年月日滚动控制器
  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;

  @override
  void initState() {
    super.initState();
    yearController = FixedExtentScrollController();
    monthController = FixedExtentScrollController();
    dayController = FixedExtentScrollController();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //年月日列表绘制完成后，默认跳转到要显示的位置
      yearController.jumpToItem(defYearIndex);
      monthController.jumpToItem(defMonthIndex);
      dayController.jumpToItem(defDayIndex);
    });
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //获取年月日数据集合
    List<String> yearData = _getYearData(widget.minYear, widget.maxYear);
    List<String> monthData = _getMonthData();
    List<String> dayData = _getDayData(selectMonthItem);

    //获取今天年月日
    DateTime today = DateTime.now();
    String tYear = '${today.year}年';
    String tMonth = '${today.month}月';
    String tDay = '${today.day}日';
    //获取今天年月日所在列表位置index
    defYearIndex = yearData.indexOf(tYear);
    defMonthIndex = monthData.indexOf(tMonth);
    defDayIndex = dayData.indexOf(tDay);

    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(),
          )),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //标题
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        widget.title ?? '选择日期',
                        style: const TextStyle(
                            color: ColorsWS.text333,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //年月日列表
                    SizedBox(
                      height: 230,
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 年
                          Expanded(
                              flex: 25,
                              child: _buildDateTimeList(
                                  yearData, yearController, (selectedItem) {
                                year = yearData[selectedItem];
                              })),
                          // 月
                          Expanded(
                              flex: 10,
                              child: _buildDateTimeList(
                                  monthData, monthController, (selectedItem) {
                                month = monthData[selectedItem];
                                // 集合下标对应的数据要+1 例如：index 0 => 1月
                                selectMonthItem = selectedItem + 1;
                                setState(() {
                                  //切换月份，对应天数列表滚动起始位置
                                  dayController.jumpToItem(0);
                                });
                              })),
                          // 日
                          Expanded(
                              flex: 25,
                              child: _buildDateTimeList(dayData, dayController,
                                  (selectedItem) {
                                day = dayData[selectedItem];
                              })),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //底部按钮
                    _buildBottomDialogButton(context, () {
                      String dateString = year + month + day;
                      widget.onSelectedDateTime(dateString);
                      Navigator.pop(context);
                    }),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
