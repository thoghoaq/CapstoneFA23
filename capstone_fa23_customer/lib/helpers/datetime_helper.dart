class DateTimeHelper {
  static String getDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  static String getDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}';
  }
}
