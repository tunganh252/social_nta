import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 4 * size.height / 5);
    Offset curvePoint = Offset(size.width / 2, 4 * size.height / 5);
    Offset curvePoint1 = Offset(size.width / 4, size.height);

    path.quadraticBezierTo(
        curvePoint1.dx, curvePoint1.dy, curvePoint.dx, curvePoint.dy);

    Offset curvePoint2 = Offset(3 * size.width / 4, 3 * size.height / 5);
    Offset endpoint = Offset(size.width, 4 * size.height / 5);

    path.quadraticBezierTo(
        curvePoint2.dx, curvePoint2.dy, endpoint.dx, endpoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
