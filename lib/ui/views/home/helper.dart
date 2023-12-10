import 'package:intl/intl.dart';

String dateTimeParse(String date) {
  DateTime dateTime = DateTime.parse(date);
  final dateFormat = DateFormat('MMMM d, y');

  final datePart = dateFormat.format(dateTime);

  return '$datePart ';
}
