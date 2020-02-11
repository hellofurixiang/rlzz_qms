import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:qms/common/config/Config.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/NavigatorUtil.dart';
import 'package:qms/page/FileListPage.dart';
import 'package:qms/widget/BadgeWidget.dart';
import 'package:qms/widget/MessageDialog.dart';
import 'package:qms/widget/RemarkWidget.dart';

///控件通用类
class WidgetUtil {
  ///加载框
  static void showLoadingDialog(BuildContext context, String text) {
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Material(
            //创建透明层
            type: MaterialType.transparency, //透明类型
            child: new Center(
              //保证控件居中效果
              child: new SizedBox(
                width: 120.0,
                height: 120.0,
                child: new Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new CircularProgressIndicator(),
                      new Padding(
                        padding: new EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: new Text(
                          text,
                          // ignore: conflicting_dart_import
                          style: new TextStyle(
                              fontSize: SetConstants.smallTextSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static Widget getLoadingWidget(String text) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: new EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    // ignore: conflicting_dart_import
                    style: new TextStyle(fontSize: SetConstants.smallTextSize),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///确认框
  static void showConfirmDialog(
      BuildContext context, String content, Function confirmFun,
      {String confirmText, String cancelText, Function cancelFun}) {
    confirmText = confirmText ?? StringZh.app_ok;
    cancelText = cancelText ?? StringZh.app_cancel;

    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
              title: StringZh.app_tip,
              message: content,
              cancelText: cancelText,
              okText: confirmText,
              onCancelEvent: () {
                Navigator.of(context).pop();
                if (cancelFun != null) {
                  cancelFun();
                }
              },
              onOkEvent: () {
                Navigator.of(context).pop();
                confirmFun();
              });
        });
  }

  ///获取主菜单布局
  ///item 数据项
  ///crossAxisCount 一行排列数量
  static Widget buildListItem(
      BuildContext context, var item, int crossAxisCount,
      {MainAxisAlignment mainAxisAlignment, Function backCall}) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 30.0,
          padding: new EdgeInsets.only(left: 5.0),
          decoration: new BoxDecoration(
              border: new Border(
            bottom: new BorderSide(color: Colors.grey),
          )),
          child: new Align(
            alignment: Alignment.centerLeft,
            child: new Text(item['tabName'], textAlign: TextAlign.start),
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(left: 10.0, top: 5.0),
          child: buildGridView(context, item, crossAxisCount,
              mainAxisAlignment: mainAxisAlignment, backCall: backCall),
        ),
        new Container(
          height: 10.0,
          color: SetColors.lightGray,
        )
      ],
    );
  }

  static Widget buildGridView(BuildContext context, item, int crossAxisCount,
      {MainAxisAlignment mainAxisAlignment, Function backCall}) {
    List menus = item['menus'];

    List newMenus = [];

    for (var menu in menus) {
      if (menu['isShow']) {
        newMenus.add(menu);
      }
    }

    List<Widget> widgetList = new List();

    for (int i = 0; i < newMenus.length / crossAxisCount; i++) {
      widgetList.add(new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: buildRows(context, newMenus, i, crossAxisCount,
              backCall: backCall)));
    }

    return new Column(
      children: widgetList,
    );
  }

  static List<Widget> buildRows(
      BuildContext context, List menus, int row, int crossAxisCount,
      {Function backCall}) {
    List<Widget> widgetList = new List();

    for (int i = row * crossAxisCount;
        i < row * crossAxisCount + crossAxisCount;
        i++) {
      if (i >= menus.length) break;
      widgetList
          .add(buildGridItemWidget(context, menus[i], backCall: backCall));
    }
    if (widgetList.length % crossAxisCount == 2) {
      widgetList.insert(widgetList.length - 1, new Container());
    }
    return widgetList;
  }

  static Widget buildGridItemWidget(BuildContext context, item,
      {Function backCall}) {
    var itemObj = item['info'];

    var img = 'assets/images/' + itemObj['img'];

    var url = itemObj['url'];
    var permissions = itemObj['permissions'];

    List<TextSpan> list = new List();

    if (item.containsKey('redName')) {
      list.add(new TextSpan(
        text: item['redName'],
        style: new TextStyle(color: Colors.red),
      ));
    }
    var count = item['count'];

    Widget badgeImage;

    // ignore: conflicting_dart_import
    Widget image = new Image.asset(
      img,
      width: 45.0,
      height: 45.0,
    );

    if (null != count && '' != count && '0' != count) {
      badgeImage = new BadgeWidget.left(
        value: count,
        child: image,
        borderSize: 1.0,
        positionTop: -12.0,
        positionRight: -8.0,
      );
    } else {
      badgeImage = image;
    }

    Widget itemWidget = new FlatButton(
      padding: new EdgeInsets.all(10.0),
      onPressed: () {
        NavigatorUtil.goToPage(context, url,
            permissions: permissions, backCall: backCall);
      },
      child: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            badgeImage,
            new Align(
              alignment: Alignment.center,
              child: new Text.rich(
                new TextSpan(
                  text: item['tabName'],
                  children: list,
                ),
              ), //new Text(menu['tabName'], textAlign: TextAlign.start),
            ),
          ],
        ),
      ),
    );

    return itemWidget;
  }

  ///获取自定义导航栏
  static AppBar getAppBar(BuildContext context, bool isBack, String title) {
    Widget leading;
    if (isBack) {
      leading = new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      );
    } else {
      leading = new Container();
    }

    return new AppBar(
      leading: leading,
      centerTitle: true,
      title: new Text(
        StringZh.app_describe,
        style: new TextStyle(
            color: Colors.white, fontSize: SetConstants.lagerTextSize),
      ),
    );
  }

  ///空页面
  static Widget buildEmpty(BuildContext context, {Function onRefresh}) {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FlatButton(
            onPressed: () {
              if (null != onRefresh) {
                onRefresh();
              }
            },
            child: new Image(
                image: new AssetImage(SetIcons.logo),
                width: 70.0,
                height: 70.0),
          ),
          new Container(
            child: new Text(StringZh.app_empty,
                style: new TextStyle(
                  fontSize: SetConstants.normalTextSize,
                )),
          ),
        ],
      ),
    );
  }

  ///列表无数据显示控件
  static Widget buildEmptyToList(BuildContext context, {Function onRefresh}) {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FlatButton(
            onPressed: () {
              if (null != onRefresh) {
                onRefresh();
              }
            },
            child: new Image(
                image: new AssetImage(SetIcons.logo),
                width: 70.0,
                height: 70.0),
          ),
          new Container(
            child: new Text(StringZh.app_empty,
                style: new TextStyle(
                  fontSize: SetConstants.smallTextSize,
                )),
          ),
        ],
      ),
    );
  }

  ///分割线
  static Widget getDivider(
      {double height: 3.0, color: SetColors.dividerColor1}) {
    return new Container(
      height: height,
      color: color,
    );
  }

  ///登录界面、主界面提示退出
  static Future<bool> dialogExitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        content: new Text(StringZh.app_back_tip),
        actions: <Widget>[
          new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text(StringZh.app_cancel)),
          new FlatButton(
            onPressed: () {
              ///系统退出
              SystemNavigator.pop();
            },
            child: new Text(StringZh.app_ok),
          ),
        ],
      ),
    );
  }

  ///列表表头配置
  ///配置对象
  ///是否有操作列
  ///背景色
  static List<Widget> renderTableHeadColumnsByConfig(
      Map<String, Object> layoutConfig,
      {bool isOper: false,
      Color backColor: SetColors.mainColor}) {
    List<Widget> columns = new List();

    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      color: backColor,
      border: new Border(right: borderSide, bottom: borderSide),
    );

    ///遍历列
    for (var cell in layoutConfig['fields']) {
      ///必填标示
      bool mandatory = cell['mandatory'] ?? false;

      var displayName = cell['displayName'];

      var fieldType = cell['fieldType'];
      if (fieldType == StringZh.listOper && !isOper) {
        displayName = '序号';
      }

      double width = cell['width'] ?? 90.0;
      double height = cell['height'] ?? 30.0;

      List<TextSpan> textSpans = new List();

      ///必填标示
      if (mandatory) {
        textSpans.add(new TextSpan(
          text: '* ',
          style: new TextStyle(
              fontSize: SetConstants.normalTextSize, color: SetColors.red),
        ));
      }

      textSpans.add(new TextSpan(
        text: displayName,
        style: new TextStyle(
            color: Colors.white, fontSize: SetConstants.normalTextSize),
      ));

      columns.add(
        new Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          child: new Text.rich(
            new TextSpan(
              text: '',
              children: textSpans,
            ),
          ),
          decoration: boxDecoration,
        ),
      );
    }

    return columns;
  }

  ///根据配置文件获取列表列宽
  ///layoutConfig 配置
  static Map<int, TableColumnWidth> getTableColumnWidth(
      Map<String, Object> layoutConfig) {
    Map<int, TableColumnWidth> map = {};

    List fields = layoutConfig['fields'];

    ///遍历列
    for (int i = 0; i < fields.length; i++) {
      var cell = fields[i];

      ///宽度
      double width = cell['width'] ?? 90.0;
      map[i] = FixedColumnWidth(width);
    }

    return map;
  }

  ///数据列表配置
  ///上下文
  ///数据列表
  ///配置
  ///点击事件
  ///是否有操作列
  static List<TableRow> renderTableRowColumnsByConfig(BuildContext context,
      List dataList, Map<String, Object> layoutConfig, Function onTap,
      {bool isOper: false}) {
    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      border: new Border(right: borderSide, bottom: borderSide),
    );

    double width = 90.0;
    double height = 35.0;

    List<TableRow> tableRowList = [];
    for (int i = 0; i < dataList.length; i++) {
      Map<String, Object> data = dataList[i];

      List<Widget> cellList = new List();

      ///遍历列
      for (var cell in layoutConfig['fields']) {
        ///字段类型
        var fieldType = cell['fieldType'];
        var fieldCode = cell['fieldCode'];

        ///字段数据
        var field = data[fieldCode];

        ///是否存在点击事件
        var isOnTap = cell['onTap'] ?? false;

        double cellWidth = cell['width'] ?? width;

        ///操作列
        if (fieldType == StringZh.listOper) {
          ///需要操作则显示操作字符，否则显示序号
          if (isOper) {
            String checkField = cell['checkField'];

            ///可操作判断
            if (checkField != null && double.parse(data[checkField]) > 0) {
              cellList.add(
                new GestureDetector(
                  child: new Container(
                    alignment: Alignment.center,
                    height: height,
                    padding: new EdgeInsets.all(2.0),
                    width: cellWidth,
                    child: new Text(
                      cell['fieldName'],
                      style: new TextStyle(
                          color: SetColors.mainColor,
                          fontSize: SetConstants.smallTextSize,
                          decoration: TextDecoration.underline),
                    ),
                    decoration: boxDecoration,
                  ),
                  onTap: () {
                    if (isOnTap) {
                      onTap(fieldCode, data);
                    }
                  },
                ),
              );
            } else {
              cellList.add(
                new Container(
                  alignment: Alignment.center,
                  height: height,
                  padding: new EdgeInsets.all(2.0),
                  width: cellWidth,
                  child: new Text(
                    cell['fieldName'],
                    style: new TextStyle(
                      color: SetColors.gray,
                      fontSize: SetConstants.smallTextSize,
                    ),
                  ),
                  decoration: boxDecoration,
                ),
              );
            }
          } else {
            cellList.add(new Container(
              height: height,
              width: cellWidth,
              alignment: Alignment.center,
              padding: new EdgeInsets.all(2.0),
              child: new Text(
                (i + 1).toString(),
                style: new TextStyle(
                    color: SetColors.mainColor,
                    fontSize: SetConstants.smallTextSize),
              ),
              decoration: boxDecoration,
            ));
          }
          continue;
        }

        List<TextSpan> textSpans = new List();

        ///前缀
        if (null != cell['prefix'] && '' != cell['prefix']) {
          textSpans.add(new TextSpan(
            text: cell['prefix'],
            //style: textStyle,
          ));
        }

        double fontSize = SetConstants.smallTextSize;
        if (null != cell['fontSize'] && '' != cell['fontSize']) {
          fontSize = cell['fontSize'];
        }

        int fieldColor = SetColors.defaultFontColorValue;
        if (null != cell['color'] && '' != cell['color']) {
          fieldColor = cell['color'];
        }

        var fieldStr = field == null ? '' : field.toString();

        ///数量
        if (fieldType == Config.fieldTypeNumber) {
          ///设置多颜色
          if (null != cell['colors'] && cell['colors'].length == 2) {
            if (double.parse(field.toString()) > 0) {
              fieldColor = cell['colors'][0];
              if (null != cell['describes'] && cell['describes'].length == 2) {
                fieldStr = cell['describes'][0] + fieldStr;
              }
            } else if (double.parse(field.toString()) < 0) {
              fieldColor = cell['colors'][1];
              if (null != cell['describes'] && cell['describes'].length == 2) {
                fieldStr = cell['describes'][1] + fieldStr;
              }
            }
          }
        }

        TextStyle textStyle = new TextStyle(
            fontSize: fontSize,
            color: isOnTap ? SetColors.mainColor : Color(fieldColor));

        ///日期
        if (fieldType == Config.fieldTypeDate) {
          var dateFormat = cell['dateFormat'];
          fieldStr =
              CommonUtil.getDateFromTimeStamp(fieldStr, dateFormat: dateFormat);
        }

        textSpans.add(new TextSpan(
          text: fieldStr,
          style: textStyle,
        ));

        ///后缀
        if (null != cell['suffix'] && '' != cell['suffix']) {
          textSpans.add(new TextSpan(
            text: cell['suffix'],
            //style: textStyle,
          ));
        }

        Widget rich = new Text.rich(
          new TextSpan(
            text: '',
            children: textSpans,
          ),
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: new TextStyle(
              decoration:
                  isOnTap ? TextDecoration.underline : TextDecoration.none),
          //maxLines: 2,
        );
        cellList.add(
          new GestureDetector(
              child: new Container(
                //color: RLZZColors.mainColor,
                alignment: Alignment.center,
                height: height,
                padding: new EdgeInsets.all(2.0),
                width: cellWidth,
                child: new SingleChildScrollView(
                  child: rich,
                ),
                decoration: boxDecoration,
              ),
              onTap: () {
                if (isOnTap) {
                  onTap(fieldCode, data);
                } else {
                  showRemark(context, remark: fieldStr);
                }
              }),
        );
      }
      tableRowList.add(new TableRow(children: cellList));
    }
    return tableRowList;
  }

  ///报表列表配置
  static List<TableRow> renderTableRowColumnsByConfigForReport(
    BuildContext context,
    List dataList,
    Map<String, Object> layoutConfig,
  ) {
    var borderSide = new BorderSide(color: SetColors.darkGrey, width: 0.5);

    var boxDecoration = new BoxDecoration(
      border: new Border(right: borderSide, bottom: borderSide),
    );

    var boxDecorationCenter = new BoxDecoration(
      border: new Border(top: borderSide),
    );

    double height = 20.0;
    double mainHeight = 45.0;

    List<TableRow> tableRowList = [];
    for (int i = 0; i < dataList.length; i++) {
      Map<String, Object> data = dataList[i];

      List<Widget> cellList = new List();

      ///遍历列
      for (var cell in layoutConfig['fields']) {
        var fieldCode = cell['fieldCode'];

        var isSpit = cell['isSpit'] ?? false;

        var inputType = cell['inputType'];
        var fieldNames = cell['fieldNames'];

        double cellWidth = cell['width'];

        double fontSize = SetConstants.smallTextSize;

        if (null != cell['fontSize'] && '' != cell['fontSize']) {
          fontSize = cell['fontSize'];
        }

        int fieldColor = SetColors.defaultFontColorValue;
        if (null != cell['color'] && '' != cell['color']) {
          fieldColor = cell['color'];
        }

        TextStyle textStyle =
            new TextStyle(fontSize: fontSize, color: Color(fieldColor));

        if (inputType == Config.inputTypeReadonly) {
          cellList.add(
            new Container(
              alignment: Alignment.center,
              height: mainHeight,
              width: cellWidth,
              padding: new EdgeInsets.all(2.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    height: height,
                    child: new Text(
                      fieldNames[0],
                      style: textStyle,
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    height: height,
                    child: new Text(
                      fieldNames[1],
                      style: textStyle,
                    ),
                    decoration: boxDecorationCenter,
                  )
                ],
              ),
              decoration: boxDecoration,
            ),
          );

          continue;
        }

        if (isSpit) {
          ///字段数据
          var field1 = data[fieldCode[0]];

          var fieldStr1 = field1 == null ? '' : field1.toString();

          var field2 = data[fieldCode[1]];

          var fieldStr2 = field2 == null ? '' : field2.toString();
          cellList.add(new Container(
            alignment: Alignment.center,
            height: mainHeight,
            width: cellWidth,
            padding: new EdgeInsets.all(2.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  height: height,
                  child: new Text(
                    fieldStr1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
                new Container(
                  alignment: Alignment.center,
                  height: height,
                  child: new Text(
                    fieldStr2,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                  decoration: boxDecorationCenter,
                )
              ],
            ),
            decoration: boxDecoration,
          ));
        } else {
          ///字段数据
          var field = data[fieldCode];

          var fieldStr = field == null ? '' : field.toString();

          cellList.add(
            new Container(
              alignment: Alignment.center,
              height: mainHeight,
              width: cellWidth,
              padding: new EdgeInsets.all(2.0),
              child: new SingleChildScrollView(
                child: new Text(
                  fieldStr,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
              decoration: boxDecoration,
            ),
          );
        }
      }
      tableRowList.add(new TableRow(children: cellList));
    }
    return tableRowList;
  }

  ///列表点击数据列显示信息
  static void showRemark(BuildContext context, {String title, String remark}) {
    String title1;
    if (null != title) {
      title1 = CommonUtil.getText(StringZh.tip_remark, [title]);
    }
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new RemarkWidget(
            title: title1,
            remark: remark,
          );
        });
  }

  ///日期控件
  /*static void getSelectDate(
      BuildContext context, DateTime initialDate, Function selectFun) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      locale: 'zh',
      minYear: 1960,
      maxYear: DateTime.now().year,
      initialYear: initialDate.year,
      initialMonth: initialDate.month,
      initialDate: initialDate.day,
      //cancel: new Text(StringZh.app_cancel),
      //confirm: new Text(StringZh.app_ok),
      dateFormat: 'yyyy-mm-dd',
      onChanged: (year, month, date) {
        //print(11);
      },
      onConfirm: (int year, int month, int date) {
        String mainDate = year.toString() +
            '-' +
            (month < 10 ? '0' + month.toString() : month.toString()) +
            '-' +
            (date < 10 ? '0' + date.toString() : date.toString());
        selectFun(mainDate);
      },
    );
  }*/

  static void getSelectDate(
      BuildContext context, DateTime initialDate, Function selectFun) {
    DatePicker.showDatePicker(
      context,
      //showTitleActions: true,
      locale: DateTimePickerLocale.zh_cn,
      initialDateTime: initialDate,
      //cancel: new Text(StringZh.app_cancel),
      //confirm: new Text(StringZh.app_ok),
      dateFormat: 'yyyy-MM-dd',
      /*onChanged: (year, month, date) {
        //print(11);
      },*/
      onConfirm: (DateTime dateTime, List<int> selectedIndex) {
        String mainDate = dateTime.year.toString() +
            '-' +
            (dateTime.month < 10
                ? '0' + dateTime.month.toString()
                : dateTime.month.toString()) +
            '-' +
            (dateTime.day < 10
                ? '0' + dateTime.day.toString()
                : dateTime.day.toString());
        selectFun(mainDate);
      },
    );
  }

  ///获取框内字体控件
  static Widget getWordFigure(String word) {
    return new Container(
      margin: new EdgeInsets.only(right: 4.0),
      alignment: Alignment.center,
      width: 14.0,
      height: 17.0,
      decoration: new BoxDecoration(
          border: Border.all(width: 1.0, color: SetColors.dividerColor)),
      child: new Text(word,
          textAlign: TextAlign.center,
          style: new TextStyle(fontSize: 10.0, color: SetColors.darkDarkGrey)),
    );
  }

  ///获取列表数据
  ///上下文
  ///加载状态
  ///数据列表
  ///字段配置
  ///点击方法
  ///第一列是否是操作列
  static Widget getListRows(BuildContext context, bool loading, List dataList,
      Map<String, Object> fieldConfig, Function rowColumnsTap,
      {bool isOper: false}) {
    return loading
        ? new Expanded(child: WidgetUtil.getLoadingWidget(StringZh.loading))
        : new Expanded(
            child: new ListView(
              children: <Widget>[
                new SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: new Column(
                    children: <Widget>[
                      new Table(
                        columnWidths:
                            WidgetUtil.getTableColumnWidth(fieldConfig),
                        children: <TableRow>[
                          new TableRow(
                            children: WidgetUtil.renderTableHeadColumnsByConfig(
                                fieldConfig,
                                isOper: isOper),
                          )
                        ],
                      ),
                      new Table(
                        columnWidths:
                            WidgetUtil.getTableColumnWidth(fieldConfig),
                        children: WidgetUtil.renderTableRowColumnsByConfig(
                            context, dataList, fieldConfig, rowColumnsTap,
                            isOper: isOper),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  ///查看文件
  static Widget getFileWidget(BuildContext context, String enclosure) {
    bool bo = false;
    if (CommonUtil.isEmpty(enclosure)) {
      bo = true;
    }
    return new GestureDetector(
      onTap: () {
        if (bo) {
          return;
        }
        List<Enclosure> enclosureList = [];

        List arr = json.decode(enclosure.replaceAll('\'', '"'));
        arr.forEach((f) {
          enclosureList.add(Enclosure.fromJson(f));
        });
        showDialog<Null>(
            context: context, //BuildContext对象
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new FileListPage(enclosureList);
            });
      },
      child: new Container(
        height: 25.0,
        alignment: Alignment.center,
        padding: new EdgeInsets.all(2.0),
        child: new Text(
          '查看附件',
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: SetConstants.smallTextSize,
              color: bo ? SetColors.lightLightGrey : SetColors.mainColor,
              decoration: bo ? TextDecoration.none : TextDecoration.underline),
        ),
        //decoration: boxDecoration,
      ),
    );
  }
}
