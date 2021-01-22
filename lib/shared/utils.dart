part of 'shared.dart';

DateTime fromStringToDate(String date) {
  var dateSplited = date.split('-').map(int.parse).toList();
  return DateTime(dateSplited[0], dateSplited[1], dateSplited[2]);
}
