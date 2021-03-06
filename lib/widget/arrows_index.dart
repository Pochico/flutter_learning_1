import 'package:flutter/material.dart';

class ArrowsIndex extends StatelessWidget {
  ArrowsIndex({Key key, @required this.isPreviousArrow});
  final bool isPreviousArrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        height: 40,
        width: 40,
        child: Icon(
          isPreviousArrow
              ? Icons.keyboard_arrow_left
              : Icons.keyboard_arrow_right,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
