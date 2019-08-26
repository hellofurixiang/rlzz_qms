import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/widget/ImageItemWidget.dart';
import 'package:qms/widget/ImageShowWidget.dart';

class ImageListWidget extends StatefulWidget {
  final List<Enclosure> enclosures;

  final bool isShowRemove;

  final double width;

  ImageListWidget(this.enclosures, {this.isShowRemove: false, this.width});

  @override
  State<StatefulWidget> createState() => ImageListWidgetState();
}

class ImageListWidgetState extends State<ImageListWidget> {
  @override
  void initState() {
    super.initState();
    //print(widget.width);
    //itemWidth = widget.width / crossAxisCount;
  }

  //int crossAxisCount = 3;
  //double itemWidth;

  Widget buildGridView() {
    if (widget.enclosures.length == 0) {
      return Container();
    } else {
      return new SingleChildScrollView(
        child: Wrap(
          spacing: 10.0,
          children: getItems(),
        ),
      );

      /*return new GridView.builder(
          itemCount: widget.enclosures.length,
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(

              ///SliverGridDelegateWithFixedCrossAxisCount可以直接指定每行（列）显示多少个Item
              ///SliverGridDelegateWithMaxCrossAxisExtent会根据GridView的宽度和你设置的每个的宽度来自动计算没行显示多少个Item

              //单个子Widget的水平最大宽度
              maxCrossAxisExtent: 150,
              //水平单个子Widget之间间距
              mainAxisSpacing: 10.0,
              //垂直单个子Widget之间间距
              crossAxisSpacing: 10.0,

              //子组件宽高长度比例
              childAspectRatio: 1),
          itemBuilder: (BuildContext context, int index) {
            var enclosure = widget.enclosures[index];
            return new ImageItemWidget(
              enclosure,
              width: itemWidth,
              removeFun: () {
                setState(() {
                  widget.enclosures.removeAt(index);
                });
              },
              isShowRemove: widget.isShowRemove,
              boxFit: BoxFit.cover,
              showFun: () {
                showDialog<Null>(
                    context: context, //BuildContext对象
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new ImageShowWidget(
                        index,
                        widget.enclosures,
                      );
                    });
              },
            );
          });*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.centerLeft,
      child: buildGridView(),
    );
  }

  List<Widget> getItems() {
    List<Widget> items = <Widget>[];
    for (int i = 0; i < widget.enclosures.length; i++) {
      items.add(new ImageItemWidget(
        widget.enclosures[i],
        width: widget.width,
        removeFun: () {
          setState(() {
            widget.enclosures.removeAt(i);
          });
        },
        isShowRemove: widget.isShowRemove,
        boxFit: BoxFit.cover,
        showFun: () {
          showDialog<Null>(
              context: context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new ImageShowWidget(
                  i,
                  widget.enclosures,
                );
              });
        },
      ));
    }
    return items;
  }
}
