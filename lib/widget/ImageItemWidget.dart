import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/style/Styles.dart';

class ImageItemWidget extends StatefulWidget {
  final Enclosure enclosure;

  final double width;
  final double height;

  final BoxFit boxFit;

  final Function removeFun;
  final Function showFun;

  final bool isShowRemove;

  ImageItemWidget(this.enclosure,
      {this.removeFun,
      this.showFun,
      this.width,
      this.height,
      this.boxFit,
      this.isShowRemove: false});

  @override
  State<StatefulWidget> createState() => ImageItemWidgetState();
}

class ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enclosure == null) {
      return new Container();
    }

    List<Widget> list = [];
    list.add(new GestureDetector(
      onTap: () {
        widget.showFun();
      },
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              width: widget.width - 25,
              height: widget.width - 30,
              child: _buildImage(),
            ),
            new Container(
              alignment: Alignment.center,
              height: 30.0,
              child: new Text(
                widget.enclosure.name ?? '',
                style: new TextStyle(
                    fontSize: RLZZConstant.smallTextSize,
                    color: RLZZColors.mainColor),
              ),
            ),
          ],
        ),
      ),
    ));

    if (widget.isShowRemove) {
      list.add(new Positioned(
        child: new GestureDetector(
          onTap: () {
            widget.removeFun();
          },
          child: new Container(
            width: 25.0,
            height: 25.0,
            decoration: new BoxDecoration(
                color: Colors.transparent,
                border: new Border.all(color: Colors.transparent, width: 1.0),
                borderRadius: new BorderRadius.circular(100.0)),
            child: new Center(
              child: new Container(
                width: 24.0,
                height: 24.0,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.white, width: 1.0),
                    borderRadius: new BorderRadius.circular(100.0)),
                child: new Icon(
                  Icons.clear,
                  size: 20.0,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ));
    }

    return new Container(
      width: widget.width,
      height: widget.width,
      alignment: Alignment.center,
      child: new Stack(
        //overflow: Overflow.visible,
        alignment: const Alignment(0.99, -0.99),
        children: list,
      ),
    );
  }

  Widget _buildImage() {
    if (null == widget.enclosure.localFile) {
      Future<Uint8List> future = widget.enclosure.uint8list;
      if (null == future) {
        future = widget.enclosure.thumbnail;
      }

      return new FutureBuilder<Uint8List>(
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return new Container(
              child: new Text('图片异常'),
            );
          }
          if (!snapshot.hasData) {
            return new Container(
              child: new Text('图片不见了'),
            );
          }
          return new Image.memory(
            snapshot.data,
            fit: BoxFit.fill,
          );
        },
        future: future,
      );
    } else {
      return new Image.file(
        widget.enclosure.localFile,
        fit: BoxFit.fill,
      );
    }
  }
}
