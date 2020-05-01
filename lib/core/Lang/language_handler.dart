import 'package:noobcaster/core/Lang/translations/DrawerTranslations.dart';
import 'package:noobcaster/core/Lang/translations/FailureMessageTranslations.dart';
import 'package:noobcaster/core/Lang/translations/SearchRouteTranslations.dart';
import 'package:noobcaster/core/Lang/translations/SettingsRouteTranslations.dart';
import 'package:noobcaster/core/Lang/translations/WeatherDataTranslations.dart';
import 'package:noobcaster/core/settings/app_settings.dart';
import 'package:noobcaster/injection_container.dart';

//Functions for adapting to language changes

String translateUVDescription() {
  return UVDESCRIPTIONMAP[sl<AppSettings>().getLocale()];
}

String translateUVLevel(double uvi) {
  if (uvi <= 2) {
    return UVLOW[sl<AppSettings>().getLocale()];
  } else if (uvi <= 5) {
    return UVMODERATE[sl<AppSettings>().getLocale()];
  } else if (uvi <= 7) {
    return UVHIGH[sl<AppSettings>().getLocale()];
  } else if (uvi <= 10) {
    return UVVERYHIGH[sl<AppSettings>().getLocale()];
  }
  return UVEXTREME[sl<AppSettings>().getLocale()];
}

String translateWind() {
  return WIND[sl<AppSettings>().getLocale()];
}

String translateHumidity() {
  return HUMIDITY[sl<AppSettings>().getLocale()];
}

String translateHour() {
  return HOUR[sl<AppSettings>().getLocale()];
}

String translateDay() {
  return DAY[sl<AppSettings>().getLocale()];
}

String translateDetails() {
  return DETAILS[sl<AppSettings>().getLocale()];
}

String translateSunrise() {
  return SUNRISE[sl<AppSettings>().getLocale()];
}

String translateSunset() {
  return SUNSET[sl<AppSettings>().getLocale()];
}

String translateWeekDay(int weekday) {
  return [
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY
  ][weekday - 1][sl<AppSettings>().getLocale()];
}

String translateUpdated() {
  return UPDATED[sl<AppSettings>().getLocale()];
}

String translateCached() {
  return CACHED[sl<AppSettings>().getLocale()];
}

String translateMyLocation() {
  return MYLOCATION[sl<AppSettings>().getLocale()];
}

String translateLastSearchedLocations() {
  return LASTSEARCHEDLOCATIONS[sl<AppSettings>().getLocale()];
}

String translateNoData() {
  return NODATA[sl<AppSettings>().getLocale()];
}

String translateSettings() {
  return SETTINGS[sl<AppSettings>().getLocale()];
}

String translateTempUnit() {
  return TEMPUNIT[sl<AppSettings>().getLocale()];
}

String translateLocale() {
  return LOCALE[sl<AppSettings>().getLocale()];
}

String translateLocaleWarning() {
  return LOCALEWARNING[sl<AppSettings>().getLocale()];
}

String translateSearch() {
  return SEARCH[sl<AppSettings>().getLocale()];
}

String translateListening() {
  return "${LISTENING[sl<AppSettings>().getLocale()]}...";
}

String translateTypeSomething() {
  return TYPESOMETHING[sl<AppSettings>().getLocale()];
}

String translateEnterALocation() {
  return ENTERALOCATION[sl<AppSettings>().getLocale()];
}

String translateServerErrorMessage() {
  return SERVERERRORMESSAGE[sl<AppSettings>().getLocale()];
}

String translateCacheErrorMessage() {
  return CACHEERRORMESSAGE[sl<AppSettings>().getLocale()];
}

String translateLocationErrorMessage() {
  return LOCATIONERRORMESSAGE[sl<AppSettings>().getLocale()];
}

String translateInputErrorMessage() {
  return INPUTERRORMESSAGE[sl<AppSettings>().getLocale()];
}
