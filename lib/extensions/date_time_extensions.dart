part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get shortDayName {
    switch (this.weekday) {
      case 1:
        return "SEN";
      case 2:
        return "SEL";
      case 3:
        return "RAB";
      case 4:
        return "KAM";
      case 5:
        return "JUM";
      case 6:
        return "SAB";
      default:
        return "MIN";
    }
  }

  String get dateInString => '${this.year}-${this.month}-${this.day}';
}
