const Map<int, String> intToDay = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thur",
  5: "Fri",
  6: "Sat",
  7: "Sun"
};

int _getRawHourFromUnix(int unixtime) {
  return DateTime.fromMillisecondsSinceEpoch(unixtime * 1000, isUtc: true).hour;
}

int _getRawMinuteFromUnix(int unixtime) {
  return DateTime.fromMillisecondsSinceEpoch(unixtime * 1000, isUtc: true)
      .minute;
}

String formattedHour(int hour) {
  return hour > 12 ? "${hour - 12} PM" : "$hour AM";
}

String formatMinute(int minute) {
  return minute >= 10 ? minute.toString() : "0" + minute.toString();
}

String formattedHourAndMinute(DateTime dateTime) {
  return "${dateTime.hour}:${formatMinute(dateTime.minute)}";
}

String dayOfWeek(int weekday) {
  return intToDay[weekday];
}

String getCurrentTime() {
  return DateTime.now().toString().substring(0, 19);
}

String formattedTime(DateTime dateTime) {
  return dateTime.toString().substring(0, 19);
}
