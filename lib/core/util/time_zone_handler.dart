import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class TimezoneHandler {
  DateTime dateTimeFromUnixAndTimezone(String timezone, int unixtime);
}

class TimezoneHandlerImpl implements TimezoneHandler {
  TimezoneHandlerImpl() {
    tz.initializeTimeZones();
  }
  @override
  DateTime dateTimeFromUnixAndTimezone(String timezone, int unixtime) {
    final location = tz.getLocation(timezone);
    return tz.TZDateTime.fromMillisecondsSinceEpoch(location, unixtime * 1000);
  }
}
