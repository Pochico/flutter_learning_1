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
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(45),
          image: isPreviousArrow
              ? DecorationImage(
                  image: AssetImage('assets/images/left_arrow.png'))
              : DecorationImage(
                  image: AssetImage('assets/images/right_arrow.png')),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.6),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
