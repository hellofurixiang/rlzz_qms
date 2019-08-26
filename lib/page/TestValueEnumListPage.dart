import 'package:flutter/material.dart';
import 'package:qms/common/modal/DetailEnumInfo.dart';
import 'package:qms/common/modal/EnumInfoVo.dart';
import 'package:qms/common/net/QmsService.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';

///检测值录入列表(枚举型)
class TestValueEnumListPage extends StatefulWidget {
  ///检验单表体ID
  final String testOrderDetailId;

  ///检测值列表 缓存数据
  final List valueList;

  ///标准值
  final String standardValue;

  ///报检数量
  final double qty;

  ///确认回调
  final Function okFun;

  ///检验指标ID
  final String testQuotaCode;

  TestValueEnumListPage(
      {Key key,
      @required this.qty,
      @required this.okFun,
      @required this.valueList,
      this.testOrderDetailId,
      @required this.testQuotaCode,
      @required this.standardValue});

  @override
  TestValueEnumListPageState createState() => new TestValueEnumListPageState();
}

class TestValueEnumListPageState extends State<TestValueEnumListPage> {
  ///数据列表
  List<DetailEnumInfo> dataList = List();

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

    if (null != widget.valueList && widget.valueList.length > 0) {
      ///复制列表第一个元素
      DetailEnumInfo res = detailEnumInfoCopy(widget.valueList[0]);

      ///设置选项中选中状态false
      res.detailList.forEach((f) {
        f.status = 0;
      });

      for (int i = 0; i < count; i++) {
        bool bo = false;
        for (int j = 0; j < widget.valueList.length; j++) {
          if (widget.valueList[j].rowNum == i + 1) {
            dataList.add(widget.valueList[j]);
            bo = true;
            break;
          }
        }
        if (!bo) {
          DetailEnumInfo copyVo = detailEnumInfoCopy(res);
          copyVo.rowNum = i + 1;
          dataList.add(copyVo);
        }
      }
    } else {
      changeInitData(count);
    }
  }

  changeInitData(int count) {
    ///通过指标ID获取检验指标枚举选项列表
    QmsService.getEnumListInfoByQuotaId(context, widget.testQuotaCode, (res) {
      if (CommonUtil.isNotEmpty(widget.testOrderDetailId)) {
        List<EnumInfoVo> enumInfoVoList = List();
        for (int i = 0; i < res.length; i++) {
          enumInfoVoList.add(EnumInfoVo.fromJson(res[i]));
        }

        ///复制枚举选项
        QmsService.getEnumInfoListInfo(
            context, widget.testOrderDetailId, widget.testQuotaCode, (res) {
          List<DetailEnumInfo> voList = List();

          for (int i = 0; i < res.length; i++) {
            voList.add(DetailEnumInfo.fromJson(res[i]));
          }

          setState(() {
            for (int i = 0; i < count; i++) {
              bool bo = false;
              for (int j = 0; j < voList.length; j++) {
                if (voList[j].rowNum == i + 1) {
                  dataList.add(voList[j]);
                  bo = true;
                  break;
                }
              }
              if (!bo) {
                DetailEnumInfo copyVo = DetailEnumInfo.empty();
                copyVo.rowNum = i + 1;
                copyVo.detailList = enumInfoVoListCopy(enumInfoVoList);
                copyVo.testQuotaCode = widget.testQuotaCode;
                dataList.add(copyVo);
              }
            }
          });
        }, (err) {});
      } else {
        List<EnumInfoVo> voList = List();
        for (int i = 0; i < res.length; i++) {
          EnumInfoVo enumInfoVo = EnumInfoVo.fromJson(res[i]);

          ///标准值默认选中
          if (enumInfoVo.enumValue == widget.standardValue) {
            enumInfoVo.status = 1;
          }

          voList.add(enumInfoVo);
        }

        setState(() {
          ///复制枚举选项
          for (int i = 0; i < count; i++) {
            DetailEnumInfo detailEnumInfo = DetailEnumInfo.empty();
            detailEnumInfo.rowNum = i + 1;
            detailEnumInfo.detailList = enumInfoVoListCopy(voList);
            detailEnumInfo.testQuotaCode = widget.testQuotaCode;

            dataList.add(detailEnumInfo);
          }
        });
      }
    });
  }

  ///数据拷贝
  DetailEnumInfo detailEnumInfoCopy(DetailEnumInfo oldVo) {
    DetailEnumInfo vo = new DetailEnumInfo(
      oldVo.testQuotaCode,
      oldVo.rowNum,
      oldVo.testOrderDetailId,
      oldVo.quotaType,
      enumInfoVoListCopy(oldVo.detailList),
    );
    return vo;
  }

  List<EnumInfoVo> enumInfoVoListCopy(List<EnumInfoVo> oldList) {
    List<EnumInfoVo> list = [];

    oldList.forEach((f) {
      list.add(enumInfoVoCopy(f));
    });

    return list;
  }

  EnumInfoVo enumInfoVoCopy(EnumInfoVo oldVo) {
    EnumInfoVo vo = new EnumInfoVo(
        oldVo.id, oldVo.rowNum, oldVo.enumValue, oldVo.status, oldVo.quotaType);
    return vo;
  }

  clickFunOK() {
    String testQtyInfo = '';

    ///返回
    List returnStrList = List();
    List returnList = List();

    dataList.forEach((f) {
      List<EnumInfoVo> detailList = f.detailList;
      bool bo = false;
      for (int i = 0; i < detailList.length; i++) {
        if (detailList[i].status == 1) {
          bo = true;
          break;
        }
      }
      if (bo) {
        returnList.add(f);
      }
      for (int i = 0; i < detailList.length; i++) {
        if (detailList[i].status == 1) {
          returnStrList.add(detailList[i].enumValue);
        }
      }
    });

    if (returnStrList.length > 0) {
      testQtyInfo = returnStrList.join('|');
    }
    widget.okFun(testQtyInfo, returnList);
    Navigator.pop(context);
  }

  Widget getItem(List<EnumInfoVo> voList, int index) {
    EnumInfoVo vo = voList[index];

    return new GestureDetector(
      onTap: () {
        setState(() {
          if (vo.quotaType) {
            vo.status = vo.status == 1 ? 0 : 1;
          } else {
            voList.forEach((f) {
              f.status = 0;
            });

            if (vo.status == 0) {
              vo.status = 1;
            }
          }
        });
      },
      child: new Container(
        //height: 25.0,
        //padding: EdgeInsets.all(4.0),
        alignment: Alignment.center,
        child: new Text(
          vo.enumValue,
          style: new TextStyle(
              fontSize: RLZZConstant.bitSmallTextSize,
              color: vo.status == 1 ? Colors.white : Colors.black),
        ),
        decoration: BoxDecoration(
          color:
              vo.status == 1 ? RLZZColors.mainColor : RLZZColors.lightLightGrey,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      ),
    );
  }

  ///组建数据
  List<Widget> getItems() {
    //List<TextEditingController> textEditingControllers = new List();
    List<Widget> list = List();

    for (int i = 0; i < dataList.length; i++) {
      DetailEnumInfo v = dataList[i];

      var item = new Container(
          //alignment: Alignment.center,
          //margin: EdgeInsets.only(top: 10.0),
          height: 40.0,
          //width: 70.0,
          child: new Row(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                width: 30.0,
                child: new Text(
                  (i + 1).toString(),
                  style: new TextStyle(
                      fontSize: RLZZConstant.normalTextSize,
                      color: RLZZColors.darkDarkGrey),
                ),
              ),
              new Expanded(
                child: new Container(
                  padding: EdgeInsets.all(6.0),
                  child: new GridView.builder(
                      itemCount: v.detailList.length,
                      gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(

                          ///SliverGridDelegateWithFixedCrossAxisCount可以直接指定每行（列）显示多少个Item
                          ///SliverGridDelegateWithMaxCrossAxisExtent会根据GridView的宽度和你设置的每个的宽度来自动计算没行显示多少个Item

                          //单个子Widget的水平最大宽度
                          maxCrossAxisExtent: 80,
                          //水平单个子Widget之间间距
                          mainAxisSpacing: 5.0,
                          //垂直单个子Widget之间间距
                          crossAxisSpacing: 5.0,
                          //子组件宽高长度比例
                          childAspectRatio: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return getItem(v.detailList, index);
                      }),
                ),
              ),
            ],
          ));
      list.add(item);
      list.add(
          WidgetUtil.getDivider(height: 1.0, color: RLZZColors.dividerColor));
    }
    list.add(new Container(margin: EdgeInsets.only(bottom: 20.0)));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    double height = CommonUtil.getScreenHeight(context);

    List<Widget> wList = getItems();

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
                    //color: RLZZColors.mainColor,
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
                              //color: Colors.white
                            ),
                          ),
                          /*decoration: new BoxDecoration(
                            //color: RLZZColors.mainColor,
                            border: new Border(
                              right: new BorderSide(
                                  color: RLZZColors.darkGrey, width: 0.5),
                              left: new BorderSide(
                                  color: RLZZColors.darkGrey, width: 0.5),
                            ),
                          ),*/
                        ),
                        new Expanded(
                          child: new Container(
                            alignment: Alignment.center,
                            child: Text(
                              '检测值',
                              style: TextStyle(
                                fontSize: RLZZConstant.normalTextSize,
                                //color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WidgetUtil.getDivider(
                      height: 1.0, color: RLZZColors.dividerColor),
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
                  new Container(
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
