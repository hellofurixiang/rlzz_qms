import 'package:flutter/material.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/InputNumberValue.dart';
import 'package:qms/common/modal/InputTextValue.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/InputWidget.dart';

///检测值录入列表(录入型)
class TestValueListPage extends StatefulWidget {
  ///检验单表体ID
  final String testOrderDetailId;

  ///检测值列表
  final List valueList;

  ///检测值类型
  final String quotaCat;

  ///标准值
  final String standardValue;

  ///报检数量
  final double qty;

  ///确认回调
  final Function okFun;

  TestValueListPage({
    Key key,
    @required this.quotaCat,
    @required this.qty,
    @required this.okFun,
    @required this.valueList,
    @required this.standardValue,
    this.testOrderDetailId,
  });

  @override
  TestValueListPageState createState() => new TestValueListPageState();
}

class TestValueListPageState extends State<TestValueListPage> {
  ///数据列表
  List<InputTextValue> dataList = <InputTextValue>[];

  ///服务器获取数据(录入型数据用、枚举型不用)
  //List resList = List();

  ///返回
  List returnList = List();

  List<Widget> wList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  ///当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    super.dispose();
  }

  initData() {
    int count = widget.qty.toInt();

    if (widget.qty > count) {
      count++;
    }
    for (int i = 0; i < count; i++) {
      InputTextValue inputVal = InputTextValue.empty();

      ///预制标准值
      if (Config.quotaTypeEntryNumber == widget.quotaCat) {
        try {
          inputVal.testQty = double.parse(widget.standardValue).toString();
        } catch (e) {}
      } else {
        inputVal.testQty = widget.standardValue;
      }
      dataList.add(inputVal);
    }

    if (null != widget.valueList && widget.valueList.length > 0) {
      changeInitData(widget.valueList);
    } else {
      if (CommonUtil.isNotEmpty(widget.testOrderDetailId)) {
        ///通过检验单表体ID获取检测值列表
        QmsService.getInputInfoListInfo(context, widget.testOrderDetailId,
            (res) {
          List list = [];
          if (Config.quotaTypeEntryNumber == widget.quotaCat) {
            for (int i = 0; i < res.length; i++) {
              list.add(InputNumberValue.fromJson(res[i]));
            }
          } else {
            for (int i = 0; i < res.length; i++) {
              list.add(InputTextValue.fromJson(res[i]));
            }
          }
          changeInitData(list);
        }, _errorCallBack);
      } else {
        wList = getItems();
      }
    }
  }

  changeInitData(List list) {
    setState(() {
      //resList = res;
      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < list.length; j++) {
          if (list[j].rowNum == i + 1) {
            dataList[i].testQty = list[j].testQty.toString();
            break;
          }
        }
      }
      wList = getItems();
    });
  }

  _errorCallBack() {}

  clickFunOK() {
    String testQtyInfo = '';

    ///数字
    if (Config.quotaTypeEntryNumber == widget.quotaCat) {
      List<double> list = List();
      for (int i = 0; i < dataList.length; i++) {
        if (CommonUtil.isNotEmpty(dataList[i].testQty)) {
          InputNumberValue v = InputNumberValue.empty();

          v.rowNum = i + 1;
          v.testQty = double.parse(dataList[i].testQty);
          returnList.add(v);
          list.add(double.parse(dataList[i].testQty));
        }
      }

      if (list.length == 1) {
        testQtyInfo = list[0].toString();
      } else if (list.length > 1) {
        list.sort((left, right) => left.compareTo(right));

        testQtyInfo =
            list[0].toString() + '-' + list[list.length - 1].toString();
      }

      ///文本
    } else if (Config.quotaTypeEntryText == widget.quotaCat) {
      List<String> list = List();
      for (int i = 0; i < dataList.length; i++) {
        if (CommonUtil.isNotEmpty(dataList[i].testQty)) {
          InputTextValue v = InputTextValue.empty();
          v.rowNum = i + 1;
          v.testQty = dataList[i].testQty;
          returnList.add(v);
          list.add(dataList[i].testQty);
        }
      }

      if (list.length == 1) {
        testQtyInfo = list[0];
      } else if (list.length > 1) {
        list.sort((left, right) => left.compareTo(right));
        testQtyInfo = list.join('|');
      }
    }

    widget.okFun(testQtyInfo, returnList);
    Navigator.pop(context);
  }

  ///组建数据
  List<Widget> getItems() {
    //List<TextEditingController> textEditingControllers = new List();
    List<Widget> list = List();

    ///数字
    bool isNumber = false;
    if (Config.quotaTypeEntryNumber == widget.quotaCat) {
      isNumber = true;
    }

    for (int i = 0; i < dataList.length; i++) {
      /*for (int j = 0; j < resList.length; j++) {
        if (resList[j]['rowNum'] == i + 1) {
          dataList[i].testQty = resList[j]['testQty'].toString();
          break;
        }
      }*/

      var item = new Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 30.0,
          //width: 70.0,
          child: new Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                width: 60.0,
                child: new Text(
                  (i + 1).toString(),
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: RLZZColors.darkDarkGrey),
                ),
              ),
              new Expanded(
                child: new Container(
                  margin: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: new InputWidget(
                    isNumber: isNumber,
                    initText: dataList[i].testQty == null
                        ? ''
                        : dataList[i].testQty.toString(),
                    onChanged: (v) {
                      dataList[i].testQty = v;
                    },
                  ),
                ),
              ),
            ],
          ));
      list.add(item);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    double height = CommonUtil.getScreenHeight(context);

    ///操作按钮
    List<Widget> btnList = new List();
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: RLZZColors.darkGrey,
      text: StringZh.app_cancel,
      fontColor: Colors.white,
      clickFun: () {
        Navigator.pop(context);
      },
    ));

    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: RLZZColors.mainColor,
      text: StringZh.app_ok,
      fontColor: Colors.white,
      clickFun: clickFunOK,
    ));

    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              width: width,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              alignment: Alignment.center,
              width: width * 0.5,
              height: height * 0.6,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 35.0,
                    alignment: Alignment.center,
                    child: Text(
                      StringZh.testValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: RLZZConstant.normalTextSize),
                    ),
                    decoration: BoxDecoration(
                      color: RLZZColors.lightGray,
                      borderRadius:
                          new BorderRadius.vertical(top: Radius.circular(6.0)),
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.all(2.0),
                    color: RLZZColors.mainColor,
                    height: 25.0,
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.center,
                          width: 60.0,
                          child: Text(
                            '样本号',
                            style: TextStyle(
                                fontSize: RLZZConstant.normalTextSize,
                                color: Colors.white),
                          ),
                          decoration: new BoxDecoration(
                            color: RLZZColors.mainColor,
                            border: new Border(
                              right: new BorderSide(
                                  color: RLZZColors.darkGrey, width: 0.5),
                              left: new BorderSide(
                                  color: RLZZColors.darkGrey, width: 0.5),
                            ),
                          ),
                        ),
                        new Expanded(
                          child: new Container(
                            alignment: Alignment.center,
                            child: Text(
                              '检测值',
                              style: TextStyle(
                                  fontSize: RLZZConstant.normalTextSize,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: wList.length == 0
                        ? new Container()
                        : new Container(
                            child: new ListView(
                              children: wList,
                            ),
                          ),
                  ),
                  WidgetUtil.getDivider(
                      height: 1.0, color: RLZZColors.darkGrey),
                  Container(
                    margin:
                        new EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: btnList,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
