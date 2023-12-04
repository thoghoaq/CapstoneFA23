class DateTimeHelper {
  static String getDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  static String getDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}';
  }

  static DateTime parse(String dateString) {
    List<String> parts = dateString.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  static bool isToday(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    return dateTime.day == now.day &&
        dateTime.month == now.month &&
        dateTime.year == now.year;
  }

  static String convertSecondsToHourMinute(int? totalSeconds) {
    if (totalSeconds == null || totalSeconds < 0) {
      throw ArgumentError("Invalid totalSeconds value");
    }

    int totalMinutes = (totalSeconds / 60).floor();
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    if (hours > 0) {
      return '$hours tiếng ${minutes.toString().padLeft(2, '0')} phút';
    } else {
      return '$minutes phút';
    }
  }
}
