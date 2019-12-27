import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///搜索输入框
class InputWidget extends StatefulWidget {
  ///初始值
  final String initText;

  ///文本改变事件
  final ValueChanged<String> onChanged;

  ///回车提交事件
  final ValueChanged<String> onSubmitted;

  ///描述文本
  final String hintText;

  ///文字居中
  final bool isCenter;

  ///清除按钮回调
  final Function clearCallBack;

  ///所有边框有阴影效果
  final bool isAllBorder;

  ///显示搜索图标
  final bool isSearch;

  ///自动获取焦点
  final bool isAutofocus;

  ///明文显示
  final bool obscureText;

  final TextEditingController controller;

  ///键盘类型
  final TextInputType keyboardType;

  ///文本框填充颜色
  final Color textFillColor;

  ///文本框父控件填充颜色
  final Color containerFillColor;

  ///空提示
  final bool isShowPrompt;

  ///提示信息
  final String promptText;

  ///字体颜色、大小
  final Color textColor;
  final double textSize;

  ///是否可编辑
  final bool enabled;

  ///数字类型
  final bool isNumber;

  ///最大行数
  final int maxLines;

  InputWidget(
      {this.onChanged,
      this.onSubmitted,
      this.hintText,
      this.isCenter: false,
      this.clearCallBack,
      this.isAllBorder: false,
      this.isSearch: false,
      this.isAutofocus: false,
      this.initText,
      this.obscureText: false,
      this.controller,
      this.keyboardType,
      this.textFillColor: Colors.white,
      this.containerFillColor: Colors.white,
      this.isShowPrompt: false,
      this.promptText,
      this.textColor: Colors.black,
      this.textSize: SetConstants.normalTextSize,
      this.enabled: true,
      this.isNumber: false,
      this.maxLines: 1});

  @override
  InputWidgetState createState() => new InputWidgetState();
}

class InputWidgetState extends State<InputWidget> {
  @override
  initState() {
    super.initState();

    controller = widget.controller ?? new TextEditingController();

    if (null != widget.initText) controller.text = widget.initText;

    if (controller.text != '') {
      showClear = true;
    }
    controller.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: controller.text.length));
  }

  @override
  void dispose() {
    super.dispose();
    //controller.dispose();
  }

  ///文本控制器
  TextEditingController controller;

  ///回车触发搜索
  bool isEnterSearch = false;

  ///清除图标显示
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];

    TextInputType keyboardType = widget.keyboardType;

    if (widget.isNumber) {
      inputFormatters = [
        WhitelistingTextInputFormatter(CommonUtil.getRegExp('number'))
      ];

      keyboardType = TextInputType.number;
    }

    Widget clearWidget;
    if (widget.enabled && showClear) {
      clearWidget = new GestureDetector(
        onTap: () {
          controller.clear();
          setState(() {
            showClear = false;
          });
          if (null != widget.clearCallBack) widget.clearCallBack();
          if (null != widget.onChanged) widget.onChanged(controller.text);
        },
        child: new Icon(
          Icons.clear,
          size: 20.0,
        ),
      );
    }

    return new Container(
      child: new TextField(
          maxLines: widget.maxLines,
          inputFormatters: inputFormatters,
          enabled: widget.enabled,
          style:
              new TextStyle(fontSize: widget.textSize, color: widget.textColor),
          textAlign: widget.isCenter ? TextAlign.center : TextAlign.left,
          autofocus: widget.isAutofocus,
          decoration: new InputDecoration(
            ///输入内容距离上下左右的距离 ，可通过这个属性来控制 TextField的高度
            contentPadding:
                EdgeInsets.all(widget.enabled && showClear ? 4.0 : 7.0),
            hintText: widget.hintText,
            fillColor: widget.enabled
                ? widget.textFillColor
                : SetColors.lightLightGrey,
            filled: true,
            // 以下属性可用来去除TextField的边框
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  new BorderSide(color: SetColors.lightLightGrey, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  new BorderSide(color: SetColors.darkGrey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide:
                  new BorderSide(color: SetColors.mainColor, width: 1.0),
            ),
            suffixIcon: clearWidget,
          ),
          controller: controller,
          onChanged: (v) {
            setState(() {
              if (v != '') {
                showClear = true;
              } else {
                showClear = false;
              }
            });
            if (null != widget.onChanged) widget.onChanged(v);
          },
          onSubmitted: (v) {
            if ('' == v) {
              if (widget.isShowPrompt) {
                Fluttertoast.showToast(
                    msg: widget.promptText, timeInSecForIos: 3);
              }
              return;
            }
            //isEnterSearch = true;
            if (null != widget.onSubmitted) widget.onSubmitted(v);
          },
          obscureText: widget.obscureText,
          keyboardType: keyboardType),
    );
  }
}
