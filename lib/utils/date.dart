import 'package:flutter/material.dart';

String dateTimeToString(DateTime currentDay) {
  int anoActual = currentDay.year;
  int mesActual = currentDay.month;
  int diaActual = currentDay.day;

  return '$anoActual-$mesActual-$diaActual';
}

DateTime addDay(DateTime newDate) {
  newDate.add(Duration(days: 1));
  return newDate;
}

DateTime subDay(DateTime newDate) {
  newDate = newDate.subtract(Duration(days: 1));
  return newDate;
}

bool compareDate(DateTime currentDay, bool isTodayDate) {
  DateTime currentDayUtc =
      DateTime.utc(currentDay.year, currentDay.month, currentDay.day);

  int yearToday = DateTime.now().year;
  int monthToday = DateTime.now().month;
  int dayToday = DateTime.now().day;
  DateTime today = DateTime.utc(yearToday, monthToday, dayToday);

  final bool comparison = today.compareTo(currentDayUtc) == 0;
  print('comparison');
  print(comparison);

  return comparison;
}
