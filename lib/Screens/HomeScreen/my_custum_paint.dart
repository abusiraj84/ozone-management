import 'package:flutter/material.dart';

class MyCustomPaint extends StatelessWidget {
  const MyCustomPaint({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 368,
                                child: CustomPaint(
                                  painter: CurvePainter3(),
                                ),
                              ),
                            ),
                             Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 360,
                                child: CustomPaint(
                                  painter: CurvePainter(),
                                ),
                              ),
                            ),
                              Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 320,
                                child: CustomPaint(
                                  painter: CurvePainter2(),
                                ),
                              ),
                            )
      ]
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.amber;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.40);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class CurvePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff4b7ef6);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.42);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.42);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class CurvePainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.50);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}