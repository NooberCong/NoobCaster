import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const Map<String, String> Locales = {
  "English": "en_US",
  "Português": "pt_PT",
  "हिन्दी": "hi_IN",
  "한국어": "ko_KR",
  "русский": "ru_RU",
  "日本語": "ja_JP",
  "Français": "fr_FR",
  "Español": "es_ES",
  "Tiếng Việt": "vi_VN",
  "普通话": "cmn_CN",
};


const TEMP_CONFIG = "TEMP_CONFIG";
const LOCALE_CONFIG = "LOCALE_CONFIG";

abstract class AppSettings {
  String getTempUnit();
  void setTempUnit(String unit);
  String getLocale();
  void setLocale(String locale);
}

class AppSettingsImpl implements AppSettings {
  final SharedPreferences preferences;
  AppSettingsImpl({@required this.preferences});
  @override
  String getLocale() {
    return preferences.getString(LOCALE_CONFIG) ?? "en_US";
  }

  @override
  String getTempUnit() {
    return preferences.get(TEMP_CONFIG) ?? "°C";
  }

  @override
  void setLocale(String locale) {
    preferences.setString(LOCALE_CONFIG, locale);
  }

  @override
  void setTempUnit(String unit) {
    preferences.setString(TEMP_CONFIG, unit);
  }
}
