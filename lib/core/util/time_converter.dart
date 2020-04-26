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

String getHourFromUnix(int unixtime) {
  final int hour = _getRawHourFromUnix(unixtime);
  return hour > 12 ? "${hour - 12} PM" : "$hour AM";
}

String formatMinute(int minute) {
  return minute >= 10 ? minute.toString() : "0" + minute.toString();
}

String getHourAndMinute(int unixtime) {
  return "${_getRawHourFromUnix(unixtime)}:${formatMinute(_getRawMinuteFromUnix(unixtime))}";
}

String getDayOfWeekFromUnix(int unixtime) {
  final int weekDay =
      DateTime.fromMillisecondsSinceEpoch(unixtime * 1000).weekday;
  return intToDay[weekDay];
}

String getCurrentTime() {
  return DateTime.now().toString().substring(0, 19);
}

String userGreetingBasedOnTime(int unixtime) {
  final int hour = _getRawHourFromUnix(unixtime);
  if (hour >= 5 && hour < 12) {
    return "Good morning";
  } else if (hour >= 12 && hour < 17) {
    return "Good afternoon";
  } else if (hour >= 17 && hour < 22) {
    return "Good evening";
  } else {
    return "Good night";
  }
}
