import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/FilterModel.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/InputWidget.dart';
import 'package:qms/widget/DateInputWidget.dart';
import 'package:qms/widget/ListFilterRefItemWidget.dart';
import 'package:qms/widget/SelectWidget.dart';

class ListFilterWidget extends StatefulWidget {
  ///项目列表
  final List<FilterModel> itemList;

  ///确定之后回调函数
  final Function callBack;

  ///重置之后回调函数
  final Function resetCallBack;

  ListFilterWidget(
      {Key key, @required this.itemList, this.callBack, this.resetCallBack})
      : super(key: key);

  @override
  ListFilterWidgetState createState() => new ListFilterWidgetState();
}

class ListFilterWidgetState extends State<ListFilterWidget> {
  @override
  initState() {
    super.initState();
    //initList = widget.itemList;
  }

  //List<FilterModel> initList;

  ///筛选项目
  List<Widget> getItemList() {
    List<Widget> widgetList = new List();
    for (FilterModel filterModel in widget.itemList) {
      switch (filterModel.itemType) {

        ///参照
        case Config.filterItemTypeRef:
          widgetList.add(new ListFilterRefItemWidget(
            filterModel: filterModel,
            itemList: widget.itemList,
            callBack: () {
              setState(() {
                ///关联参照清空
                for (FilterModel fm in widget.itemList) {
                  ///关联参照字段编码与关联参照标示相同则追加筛选条件
                  if (fm.associated == filterModel.refFlag) {
                    fm.initParam.arcCode = '';
                    fm.initParam.arcName = fm.hasAll ? StringZh.all : '';
                    break;
                  }
                }
              });
            },
          ));
          widgetList.add(WidgetUtil.getDivider());
          break;

        ///文本
        case Config.filterItemTypeInput:
          widgetList.add(getInputItem(filterModel));
          break;

        ///单选
        case Config.filterItemTypeSingleSelect:
          widgetList.add(getSingleSelectList(filterModel));
          break;

        ///多选
        case Config.filterItemTypeMultipleSelect:
          widgetList.add(getMultipleSelectList(filterModel));
          break;

        ///日期
        case Config.filterItemTypeDate:
          widgetList.add(getDateWidget(filterModel));
          break;
        default:
          break;
      }
    }

    widgetList.add(WidgetUtil.getDivider());

    return widgetList;
  }

  ///输入框
  Widget getInputItem(FilterModel filterModel) {
    return new Container(
      margin: new EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
              right: 4.0,
              bottom: 4.0,
            ),
            child: new Text(
              filterModel.itemName,
              style: new TextStyle(fontSize: SetConstants.normalTextSize),
            ),
          ),
          new InputWidget(
            initText: filterModel.returnVal[filterModel.itemCode],
            isCenter: true,
            onChanged: (v) {
              filterModel.returnVal[filterModel.itemCode] = v;
            },
          ),
        ],
      ),
    );
  }

  ///单选项
  Widget getSingleSelectList(FilterModel filterModel) {
    List<Widget> list = new List();

    for (var map in filterModel.selectList) {
      list.add(
        new SelectWidget(
          selectMap: map,
          callFun: (var selectValue) {
            setState(() {
              for (var map1 in filterModel.selectList) {
                map1.isSelect = map1.value != selectValue ? false : true;
              }
            });
          },
        ),
      );
    }

    return new Container(
      margin: new EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 4.0),
            child: new Text(
              filterModel.itemName,
              style: new TextStyle(fontSize: SetConstants.normalTextSize),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: list,
          ),
        ],
      ),
    );
  }

  ///单选项
  Widget getMultipleSelectList(FilterModel filterModel) {
    List<Widget> list = new List();

    for (var map in filterModel.selectList) {
      list.add(
        new SelectWidget(
          selectMap: map,
          callFun: (var selectValue) {
            setState(() {
              for (var map1 in filterModel.selectList) {
                if (map1.value == selectValue) {
                  map1.isSelect = !map1.isSelect;
                }
              }
            });
          },
        ),
      );
    }

    return new Container(
      margin: new EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
              right: 4.0,
              bottom: 4.0,
            ),
            child: new Text(
              filterModel.itemName,
              style: new TextStyle(fontSize: SetConstants.normalTextSize),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: list,
          ),
        ],
      ),
    );
  }

  ///日期
  Widget getDateWidget(FilterModel filterModel) {
    List<Widget> list = new List();

    List<String> itemCodes = filterModel.itemCodes;

    list.add(new Expanded(
      child: new DateInputWidget(
        height: 30.0,
        initText: filterModel.returnVal[itemCodes[0]],
        isCenter: true,
        onTapCall: (dt) {
          if (itemCodes.length > 1) {
            String end = filterModel.returnVal[itemCodes[1]];
            if (end != '') {
              ///开始日期不能大于结束日期
              if (CommonUtil.dateCompare(dt, end) > 0) {
                Fluttertoast.showToast(
                    msg: StringZh.startIsNotGreaterThanEnd, timeInSecForIos: 3);
                return false;
              }
            }
          }
          filterModel.returnVal[itemCodes[0]] = dt;
          return true;
        },
        clearCallBack: () {
          filterModel.returnVal[itemCodes[0]] = '';
        },
      ),
    ));

    if (itemCodes.length > 1) {
      list.add(new Container(
        margin: new EdgeInsets.only(
          right: 2.0,
        ),
        width: 20.0,
        child: new Icon(
          Icons.remove,
          color: SetColors.lightGray,
        ),
      ));

      list.add(new Expanded(
        child: new DateInputWidget(
          height: 30.0,
          initText: filterModel.returnVal[itemCodes[1]],
          isCenter: true,
          onTapCall: (dt) {
            String begin = filterModel.returnVal[itemCodes[0]];
            if (begin != '') {
              ///结束日期不能小于开始日期
              if (CommonUtil.dateCompare(begin, dt) > 0) {
                Fluttertoast.showToast(
                    msg: StringZh.endIsNotLessThanStart, timeInSecForIos: 3);
                return false;
              }
            }
            filterModel.returnVal[itemCodes[1]] = dt;
            return true;
          },
          clearCallBack: () {
            filterModel.returnVal[itemCodes[1]] = '';
          },
        ),
      ));
    }

    return new Container(
      margin: new EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
              right: 4.0,
              bottom: 4.0,
            ),
            child: new Text(
              filterModel.itemName,
              style: new TextStyle(fontSize: SetConstants.normalTextSize),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screen = CommonUtil.getScreenWidth(context);
    double width = Config.screenMode ? screen * 0.15 : screen * 0.6;

    Widget widgetMain = new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 40.0,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              border: Border(
                bottom:
                    new BorderSide(width: 1.0, color: SetColors.dividerColor),
              ),
            ),
            child: new Text(
              StringZh.filter,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: SetColors.mainColor,
                  fontSize: SetConstants.middleTextSize),
            ),
          ),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              //color: Colors.white,
              child: ListView(
                children: getItemList(),
              ),
            ),
          ),
          WidgetUtil.getDivider(height: 1.0, color: SetColors.dividerColor),
          new Container(
            height: 35.0,
            //color: Colors.white,
            alignment: Alignment.center,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Container(
                    alignment: Alignment.center,
                    child: new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (null != widget.resetCallBack)
                          widget.resetCallBack();
                      },
                      child: new Text(
                        StringZh.app_reset,
                        style: new TextStyle(
                            fontSize: SetConstants.middleTextSize),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                    color: SetColors.mainColor,
                    alignment: Alignment.center,
                    child: new FlatButton(
                      onPressed: () {
                        //_selectDate(context);
                        if (null != widget.callBack) widget.callBack();
                        Navigator.pop(context);
                      },
                      child: new Text(
                        StringZh.app_ok,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: SetConstants.middleTextSize),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Row(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Container(
              color: Colors.transparent,
              width: width,
            ),
          ),
          new Expanded(
            child: widgetMain,
          ),
        ],
      ),
    );
  }
}
