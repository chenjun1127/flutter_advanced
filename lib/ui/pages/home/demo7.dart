import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:biz_lib/biz_lib.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class Demo7 extends StatefulWidget {
  const Demo7({
    Key? key,
    this.bigCircleRadius = 160,
    this.smallCircleRadius = 60,
    this.pointCircleSize = 50,
    this.hue = 0,
    this.saturation = 100,
  }) : super(key: key);
  static String title = 'CustomPainter Color';
  static String routeName = 'demo7';
  final double? bigCircleRadius;
  final double? smallCircleRadius;
  final double? pointCircleSize;
  final double? hue; //需要传入的角度，一般是对应色盘的HSL颜色的H
  final double? saturation; //对应色盘的HSL颜色的S
  @override
  State<Demo7> createState() => _Demo7State();
}

class _Demo7State extends State<Demo7> {
  Color? finalColor; //用hsl方式来取最终得到的颜色，
  Color? finalColor2; //取图像像素点颜色得到最终的颜色；
  double currentAngle = 0;
  double currentSaturation = 0;

  double get width => widget.bigCircleRadius! * 2;

  double get circleThickness => bigCircleRadius - widget.smallCircleRadius!;

  double get bigCircleRadius => widget.bigCircleRadius!;

  double get smallCircleRadius => widget.smallCircleRadius!;

  double x = 0;
  double y = 0;

  @override
  void initState() {
    super.initState();
    currentAngle = widget.hue!;
    currentSaturation = widget.saturation!;
    refreshLocation();
  }

  Future<void> refreshLocation() async {
    final double h = currentAngle;
    final double thickValue = (currentSaturation - 0) / (100 - 0) * circleThickness;
    final double realRadius = thickValue + widget.smallCircleRadius!;
    final double x1 = bigCircleRadius + (realRadius - widget.pointCircleSize! ~/ 2) * cos((h - 90) * pi / 180);
    final double y1 = bigCircleRadius + (realRadius - widget.pointCircleSize! ~/ 2) * sin((h - 90) * pi / 180);
    finalColor = getColorFromHSL(currentAngle, currentSaturation);
    setState(() {
      x = (x1 - widget.pointCircleSize! ~/ 2).toDouble();
      y = (y1 - widget.pointCircleSize! ~/ 2).toDouble();
    });
    JLogger.i("计算得到坐标:x:$x,y:$y,currentSaturation:$currentSaturation,realRadius:$realRadius");
    await loadImg(context);
    await _updateColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CustomPainter Color")),
      persistentFooterButtons: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  color: finalColor2,
                  height: 36,
                  width: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("当前生成颜色:$finalColor2"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: showImage,
              child: const Text('查看canvas生成的图片'),
            ),
          ],
        ),
      ],
      body: Container(
        color: Colors.white,
        child: Center(
          child: GestureDetector(
            onTapDown: (TapDownDetails d) {
              correctPosition(d.localPosition);
            },
            onHorizontalDragUpdate: (DragUpdateDetails d) {
              correctPosition(d.localPosition);
            },
            onVerticalDragUpdate: (DragUpdateDetails d) {
              correctPosition(d.localPosition);
            },
            onHorizontalDragEnd: (DragEndDetails e) {
              // selectedFinalValue(isTailControl: true);
            },
            onVerticalDragEnd: (DragEndDetails e) {
              // selectedFinalValue(isTailControl: true);
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: width,
                  height: width,
                  color: Colors.white,
                  //点击刷新时避免重绘
                  child: RepaintBoundary(
                    key: globalKey,
                    child: CustomPaint(
                      painter: CircleColorPainter(
                        radius: width / 2,
                        center: Offset(width / 2, width / 2),
                        smallRadius: widget.smallCircleRadius,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: x,
                  top: y,
                  child: Container(
                    width: widget.pointCircleSize,
                    height: widget.pointCircleSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(widget.pointCircleSize! / 2),
                      border: Border.all(width: 2, color: Colors.white),
                      boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 14)],
                    ),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.pointCircleSize! / 2),
                      border: Border.all(width: 2, color: Colors.white),
                      color: finalColor ?? const Color.fromRGBO(255, 255, 255, 0.8),
                      boxShadow: <BoxShadow>[BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 14)],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Offset correctPosition(Offset position) {
    final double? pointRadius = widget.pointCircleSize;
    return _correctPosition(
      position: position,
      bigRadius: bigCircleRadius,
      smallRadius: smallCircleRadius,
      touchPointRadius: pointRadius!,
    );
  }

  Offset _correctPosition({
    required Offset position,
    required double bigRadius,
    required double smallRadius,
    required double touchPointRadius,
  }) {
    final double centerX = bigRadius;
    final double centerY = bigRadius;

    //点击位置到圆心距离
    final double distance = sqrt(pow(centerX - position.dx, 2) + pow(centerY - position.dy, 2));
    final int pointRadius = touchPointRadius ~/ 2;
    double? radius;
    if (distance > bigRadius - pointRadius) {
      radius = bigRadius - pointRadius;
    } else if (distance < smallRadius + pointRadius) {
      radius = smallRadius + pointRadius;
    }
    JLogger.i("centerX:$centerX,centerY:$centerY:pointRadius:$pointRadius:radius:$radius");
    Offset currentPosition;
    if (radius != null) {
      //触摸点位移到圆心坐标
      final Offset offsetPoint = Offset(position.dx - centerX, position.dy - centerY);
      // cos
      final double x = offsetPoint.dx / offsetPoint.distance * radius;
      // sin
      final double y = offsetPoint.dy / offsetPoint.distance * radius;

      //计算点位移到左上角坐标
      currentPosition = Offset(x + centerX, y + centerY);
    } else {
      currentPosition = position;
    }
    x = currentPosition.dx - widget.pointCircleSize! / 2;
    y = currentPosition.dy - widget.pointCircleSize! / 2;
    setState(() {});
    currentAngle = getRotationBetweenLines(bigCircleRadius, bigCircleRadius, currentPosition.dx, currentPosition.dy);
    finalColor = getColorFromHSL(currentAngle, currentSaturation);
    _updateColor();

    return currentPosition;
  }

  double getRotationBetweenLines(double centerX, double centerY, double xInView, double yInView) {
    // 获取夹角
    double rotation = 0;
    if (xInView == centerX && yInView < centerY) {
      rotation = 0;
    } else if (xInView == centerX && yInView > centerY) {
      rotation = 180;
    } else {
      final double yDiff = (yInView - centerY).abs();
      final double xDiff = (xInView - centerX).abs();
      final double k2 = yDiff / xDiff;
      final double angle = atan(k2);
      final double tmpDegree = (angle / pi) * 180;
      if (xInView > centerX && yInView < centerY) {
        rotation = 90 - tmpDegree;
      } else if (xInView > centerX && yInView > centerY) {
        rotation = 90 + tmpDegree;
      } else if (xInView < centerX && yInView > centerY) {
        rotation = 270.0 - tmpDegree;
      } else if (xInView < centerX && yInView < centerY) {
        rotation = 270.0 + tmpDegree;
      }
    }
    //得到当前点与中心点距离；更新坐标；
    final double d = getDistance(xInView, yInView);
    if (d >= bigCircleRadius || d <= smallCircleRadius) {
      ///更新s的值
      if (d >= bigCircleRadius) {
        currentSaturation = 100;
      } else if (d <= smallCircleRadius) {
        currentSaturation = 0;
      }
      return rotation;
    } else {
      ///更新S的值
      currentSaturation = (d - smallCircleRadius) / circleThickness * (100 - 0) + widget.pointCircleSize! ~/ 2;
      JLogger.i("currentSaturation:$currentSaturation");
      return rotation;
    }
  }

  //根据hsl来生成颜色；
  Color getColorFromHSL(double h, double s) {
    // 饱和度设定最小为5
    final double saturation = s <= 5 ? 5 : (s > 100 ? 100 : s);
    final HSLColor hslColor = HSLColor.fromAHSL(saturation / 100, h < 0 ? 0 : h, saturation / 100, 50 / 100);
    final Color color = hslColor.toColor();
    return color;
  }

  //小圆圈距离圆心的距离
  double getDistance(double xInView, double yInView) {
    final double dx = (xInView - bigCircleRadius).abs();
    final double dy = (yInView - bigCircleRadius).abs();
    return sqrt(pow(dx, 2) + pow(dy, 2));
  }

  // 用canvas画一次，生成图片
  Future<ui.Image> get rendered {
    // [CustomPainter] has its own @canvas to pass our
    // [ui.PictureRecorder] object must be passed to [Canvas]#contructor
    // to capture the Image. This way we can pass @recorder to [Canvas]#contructor
    // using @painter[SignaturePainter] we can call [SignaturePainter]#paint
    // with the our newly created @canvas
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final CircleColorPainter painter = CircleColorPainter(
      radius: width / 2,
      center: Offset(width / 2, width / 2),
      smallRadius: widget.smallCircleRadius,
    );
    final Size size = Size(width, width);
    painter.paint(canvas, size);
    return recorder.endRecording().toImage(size.width.floor(), size.height.floor());
  }

  ui.Image? _image;

  Future<void> loadImg(BuildContext context) async {
    final ui.Image renderedImage = await rendered;
    setState(() {
      _image = renderedImage;
    });
  }

  GlobalKey globalKey = GlobalKey();

  //获取图像像素点当前颜色
  Future<void> _updateColor() async {
    // 截屏，由于已经用canvas画出来了，所以这里用不到截屏了，如果没画，则需要用
    // 获取当前设备像素比
    // final double pixelRatio = ui.window.devicePixelRatio;
    // final RenderRepaintBoundary? boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    // _image = await boundary?.toImage(pixelRatio: pixelRatio);
    final ByteData? byteData = await _image!.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    final img.Image? photo = img.decodeImage(pngBytes);
    final int pixelX = (x + widget.pointCircleSize! ~/ 2).toInt();
    final int pixelY = (y + widget.pointCircleSize! ~/ 2).toInt();
    final int pixel32 = photo!.getPixelSafe(pixelX, pixelY);
    final int argb = _abgrToArgb(pixel32);
    final Color pixelColor = Color(argb);
    setState(() {
      finalColor2 = pixelColor;
    });
    JLogger.i("=>:pixelColor:$pixelColor,finalColor:$finalColor,rotation:$currentAngle,saturation:$currentSaturation");
  }

  /// Uint32 编码过的像素颜色值（#AABBGGRR)转为（#AARRGGBB）
  int _abgrToArgb(int argbColor) {
    final int r = (argbColor >> 16) & 0xFF;
    final int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  Future<void> showImage() async {
    final ByteData? pngBytes = await _image?.toByteData(format: ui.ImageByteFormat.png);
    if (context.mounted) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Canvas绘制生成的图片',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w300,
                color: Theme.of(context).primaryColor,
                letterSpacing: 1.1,
              ),
            ),
            content: Image.memory(Uint8List.view(pngBytes!.buffer)),
          );
        },
      );
    }
  }
}

class CircleColorPainter extends CustomPainter {
  CircleColorPainter({this.radius = 100, this.center, this.smallRadius});

  final double? radius;
  final Offset? center;
  final double? smallRadius;
  List<Color> colorList = <Color>[
    const Color(0xFFFF0000),
    const Color(0xFFFFFF00),
    const Color(0xFF00FF00),
    const Color(0xFF00FFFF),
    const Color(0xFF0000FF),
    const Color(0xFFFF00FF),
    const Color(0xFFFF0000),
  ];
  List<Color> colorList2 = <Color>[
    const Color(0xffffffff),
    const Color(0xffffffff),
    Colors.white.withOpacity(0.01),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // final Rect rect = Offset.zero & size;
    final Paint paint1 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.black;
    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1
      ..color = Colors.black;
    final Paint paint3 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0
      ..color = Colors.black;
    final Gradient gradient = SweepGradient(
      colors: colorList,
      transform: const GradientRotation(-pi / 2),
    );
    final Gradient gradient2 = RadialGradient(
      colors: colorList2,
      transform: const GradientRotation(-pi / 2),
      stops: const <double>[0.3, 0.4, 1],
    );

    final Rect rect = Rect.fromLTWH(0, 0, radius! * 2, radius! * 2);
    paint1.shader = gradient.createShader(rect);

    paint2.shader = gradient2.createShader(rect);
    //主色盘渐变
    canvas.drawCircle(center!, radius!, paint1);
    //白色透明渐变
    canvas.drawCircle(center!, radius!, paint2);
    //黑色小圆
    canvas.drawCircle(center!, smallRadius!, paint3);
  }

  @override
  bool shouldRepaint(covariant CircleColorPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.smallRadius != smallRadius!;
  }
}
