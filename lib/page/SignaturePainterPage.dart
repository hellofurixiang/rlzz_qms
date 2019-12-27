import 'dart:io';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qms/common/style/StringZh.dart';
import 'package:qms/common/style/Styles.dart';
import 'package:qms/common/utils/CommonUtil.dart';
import 'package:qms/common/utils/plugin/PathProvider.dart';
import 'package:qms/widget/ButtonWidget.dart';

class SignaturePainterPage extends StatefulWidget {
  final Function okFun;

  const SignaturePainterPage({Key key, @required this.okFun}) : super(key: key);

  @override
  SignaturePainterPageState createState() => new SignaturePainterPageState();
}

class SignaturePainterPageState extends State<SignaturePainterPage> {
  List<Offset> _points = <Offset>[];

  /*void generateImage() async {
    final color = Colors.primaries[widget.rd.nextInt(widget.numColors)];

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromPoints(Offset(0.0, 0.0), Offset(kCanvasSize, kCanvasSize)));

    final stroke = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, kCanvasSize, kCanvasSize), stroke);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(
          widget.rd.nextDouble() * kCanvasSize,
          widget.rd.nextDouble() * kCanvasSize,
        ),
        20.0,
        paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(200, 200);
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);

    setState(() {
      imgBytes = pngBytes;
    });
  }*/

  GlobalKey _repaintKey = GlobalKey();

  void saveToImage() async {
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    Uint8List pngBytes = byteData.buffer.asUint8List();

    Directory dir = await getTemporaryDirectory();

    String name = DateTime.now().millisecondsSinceEpoch.toString() + '.png';

    String path = dir.path + "/" + name;
    var file = File(path);
    bool exist = await file.exists();
    //print("path =${path}");
    if (exist) {
      file.delete();
    }
    File(path).writeAsBytesSync(pngBytes);
    widget.okFun(name);
  }

  @override
  Widget build(BuildContext context) {
    double width = CommonUtil.getScreenWidth(context);
    double height = CommonUtil.getScreenHeight(context);

    ///操作按钮
    List<Widget> btnList = new List();
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.darkGrey,
      text: StringZh.app_cancel,
      fontColor: Colors.white,
      clickFun: () {
        Navigator.pop(context);
      },
    ));
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.red,
      text: StringZh.clear,
      fontColor: Colors.white,
      clickFun: () {
        _points.clear();
      },
    ));
    btnList.add(ButtonWidget(
      height: 30.0,
      width: 65.0,
      backgroundColor: SetColors.mainColor,
      text: StringZh.app_ok,
      fontColor: Colors.white,
      clickFun: () {
        saveToImage();
      },
    ));

    return new Scaffold(
      body: new Center(
        child: new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          alignment: Alignment.center,
          //width: width,
          //height: height,
          child: new Column(
            children: <Widget>[
              RepaintBoundary(
                key: _repaintKey,
                child: new GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      RenderBox object = context.findRenderObject();
                      Offset _localPosition =
                          object.globalToLocal(details.globalPosition);
                      _points = new List.from(_points)..add(_localPosition);
                    });
                  },
                  onPanEnd: (DragEndDetails details) => _points.add(null),
                  child: new CustomPaint(
                    painter: new Signature(points: _points),
                    size: new Size(width, height - 65),
                  ),
                ),
              ),
              new Container(
                height: 40.0,
                color: Colors.transparent,
                padding:
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
    );
  }
}

class Signature extends CustomPainter {
  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}
