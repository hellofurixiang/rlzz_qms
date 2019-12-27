import 'package:flutter/material.dart';
import 'package:qms/common/style/Styles.dart';

///消息框
// ignore: must_be_immutable
class MessageDialog extends Dialog {
  String title;
  String message;
  String cancelText;
  String okText;
  Function onCancelEvent;
  Function onOkEvent;

  MessageDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.cancelText,
    this.okText,
    this.onOkEvent,
    @required this.onCancelEvent,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //double width = CommonUtil.getScreenWidth(context);
    //double height = CommonUtil.getScreenHeight(context);

    return new Padding(
      padding: new EdgeInsets.all(20.0),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 300.0,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              margin: new EdgeInsets.all(30.0),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(2.0),
                    child: new Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        new Center(
                          child: new Text(
                            title,
                            style: new TextStyle(
                              fontSize: SetConstants.smallTextSize,
                            ),
                          ),
                        ),
                        new GestureDetector(
                          onTap: this.onCancelEvent,
                          child: new Padding(
                            padding: new EdgeInsets.all(5.0),
                            child: new Icon(
                              Icons.close,
                              color: SetColors.darkGrey,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    color: SetColors.lineLightGray,
                    height: 1.0,
                  ),
                  new Container(
                    constraints: BoxConstraints(minHeight: 70.0),
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),

                      ///一个根据内部子控件高度来调整高度
                      child: new Text(
                        message,
                        style: TextStyle(fontSize: SetConstants.smallTextSize),
                      ),
                    ),
                  ),
                  new Container(
                    color: SetColors.lineLightGray,
                    height: 1.0,
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    if (cancelText != null && cancelText.isNotEmpty)
      widgets.add(_buildBottomCancelButton());
    if (okText != null && okText.isNotEmpty)
      widgets.add(_buildBottomOkButton());
    return new Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildBottomCancelButton() {
    return new Flexible(
      fit: FlexFit.tight,
      child: new GestureDetector(
        onTap: onCancelEvent,
        child: new Container(
          decoration: new BoxDecoration(
            border: new Border(
              right: new BorderSide(
                color: SetColors.lineLightGray,
              ),
            ),
          ),
          alignment: Alignment.center,
          height: 30.0,
          width: 60.0,
          child: new Text(
            cancelText,
            style: TextStyle(
              fontSize: SetConstants.smallTextSize,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomOkButton() {
    return new Flexible(
      fit: FlexFit.tight,
      child: new GestureDetector(
        onTap: onOkEvent,
        child: new Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          height: 30.0,
          width: 60.0,
          child: new Text(
            okText,
            style: TextStyle(
              color: SetColors.mainColor,
              fontSize: SetConstants.smallTextSize,
            ),
          ),
        ),
      ),
    );
  }
}
