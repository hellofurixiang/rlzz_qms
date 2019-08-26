import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qms/common/modal/Enclosure.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';

///图片展示界面
class ImageShowWidget extends StatefulWidget {
  final List<Enclosure> enclosures;
  final int index;

  ImageShowWidget(this.index, this.enclosures);

  @override
  State<StatefulWidget> createState() => ImageShowWidgetState();
}

class ImageShowWidgetState extends State<ImageShowWidget>
    with SingleTickerProviderStateMixin {
  var rebuild = StreamController<int>.broadcast();

  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    //double height = CommonUtil.getScreenHeight(context);
    int len = widget.enclosures.length;
    return new GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: new Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: new Stack(
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
            new Center(
              child: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ExtendedImageGesturePageView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      Enclosure item = widget.enclosures[index];
                      Widget image;

                      //File file = new File(
                      //'/data/data/com.szrlzz.rlzzwms/app_flutter/1116627908940529664.png');
                      //item.uint8list = file.readAsBytes();
                      //item.localFile = file;
                      //item.localFile = null;

                      if (null == item.file && null == item.localFile) {
                        print(888);
                        return FutureBuilder<Uint8List>(
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              return new Container(
                                padding: new EdgeInsets.all(10.0),
                                child: ExtendedImage.memory(
                                  snapshot.data,
                                  fit: BoxFit.contain,
                                  mode: ExtendedImageMode.Gesture,
                                  /*initGestureConfigHandler: GestureConfig(
                                      inPageView: true,
                                      initialScale: 1.0,
                                      //you can cache gesture state even though page view page change.
                                      //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                                      cacheGesture: false),*/
                                ),
                              );
                            } else {
                              return new Container(
                                child: new CupertinoActivityIndicator(
                                  radius: 25.0,
                                ),
                              );
                            }
                          },
                          future: item.uint8list,
                          /*thumbDataWithSize(
                              size.width.toInt(),
                              size.height.toInt(),
                            )*/
                        );
                        //});
                      } else {
                        print(999);
                        if (null != item.localFile) {
                          image = new Container(
                            padding: new EdgeInsets.all(10.0),
                            child: ExtendedImage.file(
                              item.localFile,
                              fit: BoxFit.contain,
                              mode: ExtendedImageMode.Gesture,
                              /*gestureConfig: GestureConfig(
                                  inPageView: true,
                                  initialScale: 1.0,
                                  //you can cache gesture state even though page view page change.
                                  //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                                  cacheGesture: false),*/
                            ),
                          );
                        } else {
                          image = new FutureBuilder<Size>(
                            builder: (c, s) {
                              if (!s.hasData) {
                                return Container();
                              }
                              return FutureBuilder<File>(
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    return new Container(
                                      padding: new EdgeInsets.all(10.0),
                                      child: ExtendedImage.file(
                                        snapshot.data,
                                        fit: BoxFit.contain,
                                        mode: ExtendedImageMode.Gesture,
                                        /*gestureConfig: GestureConfig(
                                            inPageView: true,
                                            initialScale: 1.0,
                                            //you can cache gesture state even though page view page change.
                                            //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                                            cacheGesture: false),*/
                                      ),
                                    );
                                  } else {
                                    return new Container(
                                      child: new CupertinoActivityIndicator(
                                        radius: 25.0,
                                      ),
                                    );
                                  }
                                },
                                future: item.file
                                /*thumbDataWithSize(
                              size.width.toInt(),
                              size.height.toInt(),
                            )*/
                                ,
                              );
                            },
                            future: item.fileSize,
                          );
                        }
                      }
                      if (index == currentIndex) {
                        return Hero(
                          tag: index.toString(),
                          child: image,
                        );
                      } else {
                        return image;
                      }
                    },
                    itemCount: len,
                    onPageChanged: (int index) {
                      currentIndex = index;
                      rebuild.add(index);
                    },
                    controller: PageController(
                      initialPage: currentIndex,
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: MySwiperPlugin(len, currentIndex, rebuild),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySwiperPlugin extends StatelessWidget {
  final int len;
  final int index;
  final StreamController<int> reBuild;

  MySwiperPlugin(this.len, this.index, this.reBuild);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<int>(
      builder: (BuildContext context, data) {
        return new DefaultTextStyle(
          style: new TextStyle(color: RLZZColors.mainColor),
          child: new Container(
            height: 50.0,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: 10.0,
                ),
                new Text(
                  "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                new Expanded(
                  child: new Container(),
                ),
                new Text(
                  "${data.data + 1}",
                ),
                new Text(
                  " / $len",
                ),
                new Container(
                  width: 10.0,
                ),
              ],
            ),
          ),
        );
      },
      initialData: index,
      stream: reBuild.stream,
    );
  }
}
