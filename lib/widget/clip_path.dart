import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomClipMenu extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, 60);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 60);
    path.quadraticBezierTo(size.width / 2, -20, 0, 60);
    return path;
  }

  Paint paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10.0
    ..color = Colors.black;

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
