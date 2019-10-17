import 'package:flutter/material.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';

///列表底部分页
class ListPageWidget extends StatefulWidget {
  final int page;
  final int size;
  final int total;
  final Function firstFun;
  final Function preFun;
  final Function nextFun;
  final Function endFun;

  ListPageWidget({
    Key key,
    this.page,
    this.size,
    this.total,
    this.firstFun,
    this.preFun,
    this.nextFun,
    this.endFun,
  }) : super(key: key);

  @override
  ListPageWidgetState createState() => new ListPageWidgetState();
}

class ListPageWidgetState extends State<ListPageWidget> {
  @override
  initState() {
    super.initState();
  }

  int getEndPage() {
    ///取余
    int yu = widget.total % widget.size;

    ///取整
    int zheng = widget.total ~/ widget.size;

    int newPage = zheng;
    if (yu > 0) {
      newPage = newPage + 1;
    }
    return newPage;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      //width: width * 0.75,
      height: 45.0,
      color: RLZZColors.lightGray,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              widget.firstFun();
            },
            child: new Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: 80.0,
              height: 45.0,
              child: new Text(StringZh.first_page,
                  style: new TextStyle(
                    fontSize: RLZZConstant.middleTextSize,
                  )),
            ),
          ),
          new GestureDetector(
            onTap: () {
              widget.preFun();
            },
            child: new Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: 80.0,
              height: 45.0,
              child: new Text(StringZh.pre_page,
                  style: new TextStyle(
                    fontSize: RLZZConstant.middleTextSize,
                  )),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            //width: 40.0,
            height: 45.0,
            margin: new EdgeInsets.only(right: 40.0, left: 40.0),
            child: new Text(
              widget.page.toString() + '/' + getEndPage().toString()+'（' + widget.total.toString() + '）',
              style: new TextStyle(
                fontSize: RLZZConstant.middleTextSize,
                //color: RLZZColors.mainColor,
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              widget.nextFun();
            },
            child: new Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: 80.0,
              height: 45.0,
              //margin: new EdgeInsets.only(right: 80.0),
              child: new Text(
                StringZh.next_page,
                style: new TextStyle(
                  fontSize: RLZZConstant.middleTextSize,
                  //color: RLZZColors.mainColor,
                ),
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              widget.endFun();
            },
            child: new Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              width: 80.0,
              height: 45.0,
              //margin: new EdgeInsets.only(right: 80.0),
              child: new Text(
                StringZh.end_page,
                style: new TextStyle(
                  fontSize: RLZZConstant.middleTextSize,
                  //color: RLZZColors.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
