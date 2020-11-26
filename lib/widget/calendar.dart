import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';

class Calendar extends StatelessWidget {
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
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2013),
                  lastDate: DateTime.now())
              .then((date) {
            int anoActual = date.year;
            int mesActual = date.month;
            int diaActual = date.day;
            String fetchedDate = '$anoActual-$mesActual-$diaActual';
            setStateCalendar(fetchedDate);
          });
        });
  }
}
// () => activateCalendar());

// activateCalendar() {
//   showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(2013),
//           lastDate: DateTime.now())
//       .then((date) {
//     int anoActual = date.year;
//     int mesActual = date.month;
//     int diaActual = date.day;
//     setState(() {
//       fetchedDate = '$anoActual-$mesActual-$diaActual';
//     });
//   });
// }
