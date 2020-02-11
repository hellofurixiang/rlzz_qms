import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/config/FieldConfig.dart';
import 'package:qms/common/modal/InvEnclosure.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/MethodChannelUtil.dart';
import 'package:qms/common/utils/WidgetUtil.dart';
import 'package:qms/widget/ButtonWidget.dart';
import 'package:qms/widget/DialogPage.dart';

///物料附件
class InvEnclosurePage extends StatefulWidget {
  final String invEnclosure;

  InvEnclosurePage(
    this.invEnclosure, {
    Key key,
  }) : super(key: key);

  @override
  InvEnclosurePageState createState() => InvEnclosurePageState();
}

class InvEnclosurePageState extends State<InvEnclosurePage> {
  @override
  initState() {
    super.initState();
    var res = json.decode(widget.invEnclosure);

    for (var k in res) {
      list.add(k);
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  List<Map<String, dynamic>> list = [];

  bool loading = true;

  _clickFunOK() {
    Navigator.pop(context);
  }

  ///列点击事件
  _rowColumnsTap(var field, var data) {
    print(field);
    switch (field) {
      case 'name':

        print('file:' + data['docFullName']);
        MethodChannelUtil.openSharedFile('file:' + data['docFullName']);

        /*NavigatorUtil.goToPage(
            context,
            new TestOrderPage(
                id: data['id'],
                docNo: data['docNo'],
                docCat: Config.test_order_arrival,
                testCat: Config.text_iqc,
                title: StringZh.arrivalTestOrderDetail_title),
            permissions: UserPermissionsConfig.arrival_view,
            permissionsText: StringZh.arrivalTestOrderDetail_view);*/

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ///操作按钮
    List<Widget> btnList = new List();

    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.mainColor,
      text: StringZh.app_close,
      fontColor: Colors.white,
      clickFun: () {
        _clickFunOK();
      },
    ));
    return new DialogPage(
      title: StringZh.invEnclosure_title,
      widthProportion: 0.8,
      heightProportion: 0.7,
      mainWidget: new ListView(
        children: <Widget>[
          new SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: new Column(
              children: <Widget>[
                new Table(
                  columnWidths:
                      WidgetUtil.getTableColumnWidth(FieldConfig.invEnclosure),
                  children: <TableRow>[
                    new TableRow(
                      children: WidgetUtil.renderTableHeadColumnsByConfig(
                          FieldConfig.invEnclosure),
                    )
                  ],
                ),
                new Table(
                  columnWidths:
                      WidgetUtil.getTableColumnWidth(FieldConfig.invEnclosure),
                  children: WidgetUtil.renderTableRowColumnsByConfig(
                      context, list, FieldConfig.invEnclosure, _rowColumnsTap),
                ),
              ],
            ),
          ),
        ],
      ),
      btnList: btnList,
    );
  }
}
