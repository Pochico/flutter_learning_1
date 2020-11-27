import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/utils/date.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key key, @required this.setState, @required this.currentDay})
      : super(key: key);
  final Function setState;
  final DateTime currentDay;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Icon(Icons.calendar_today_outlined,
              size: 32, color: Color(0xFFf2c902)),
        ),
        onTap: () {
          datePicker(context, setState, currentDay);
        });
  }
}
