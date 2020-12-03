import 'package:flutter/material.dart';

String dateTimeToString(DateTime currentDay) {
  int anoActual = currentDay.year;
  int mesActual = currentDay.month;
  int diaActual = currentDay.day;

  return '$anoActual-$mesActual-$diaActual';
}

DateTime subDay(DateTime date) {
  var newDate = date.subtract(Duration(days: 1));
  return newDate;
}

DateTime addDay(DateTime date) {
  var newDate = date.add(Duration(days: 1));
  return newDate;
}

bool compareDate(DateTime currentDay) {
  DateTime currentDayUtc =
      DateTime.utc(currentDay.year, currentDay.month, currentDay.day);

  int yearToday = DateTime.now().year;
  int monthToday = DateTime.now().month;
  int dayToday = DateTime.now().day;
  DateTime today = DateTime.utc(yearToday, monthToday, dayToday);

  final bool comparison = today.compareTo(currentDayUtc) == 0;

  return comparison;
}

// TODO: Find out why the date doesn't send and refresh the fetch

void datePicker(BuildContext context, Function setState, DateTime currentDay) {
  showDatePicker(
          context: context,
          initialDate: currentDay,
          firstDate: DateTime(2013),
          lastDate: DateTime.now())
      .then((date) {
    date != null ? setState(date) : print(currentDay);
  });
}
