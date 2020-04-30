import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const List<String> Locales = [
  "af_ZA",
  "am_ET",
  "en_AU",
  "en_CA",
  "en_GH",
  "en_US",
  "en_ID",
  "en_IE",
  "en_KE",
  "en_ZA",
  "en_NZ",
  "en_NG",
  "en_PH",
  "en_TZ",
  "en_TH",
  "en_001",
  "en_GB",
  "en_IN",
  "hy_AM",
  "az_AZ",
  "pl_PL",
  "fa_IR",
  "bn_BD",
  "bn_IN",
  "eu_ES",
  "bg_BG",
  "pt_BR",
  "pt_PT",
  "ca_ES",
  "hr_HR",
  "iw_IL",
  "et_EE",
  "gl_ES",
  "ka_GE",
  "gu_IN",
  "hi_IN",
  "hu_HU",
  "el_GR",
  "nl_NL",
  "ko_KR",
  "is_IS",
  "in_ID",
  "it_IT",
  "jv_ID",
  "kn_IN",
  "km_KH",
  "lv_LV",
  "lt_LT",
  "lo_LA",
  "ml_IN",
  "mr_IN",
  "my_MM",
  "ms_MY",
  "nb_NO",
  "ne_NP",
  "ru_RU",
  "ja_JP",
  "fil_PH",
  "fr_CA",
  "fr_FR",
  "fi_FI",
  "yue_HK",
  "ro_RO",
  "sr_RS",
  "si_LK",
  "sk_SK",
  "sl_SI",
  "su_ID",
  "sw_",
  "sw_TZ",
  "cs_CZ",
  "ta_MY",
  "ta_SG",
  "ta_LK",
  "ta_IN",
  "te_IN",
  "th_TH",
  "tr_TR",
  "sv_SE",
  "es_AR",
  "es_BO",
  "es_CL",
  "es_CO",
  "es_CR",
  "es_DO",
  "es_EC",
  "es_SV",
  "es_GT",
  "es_US",
  "es_HN",
  "es_MX",
  "es_NI",
  "es_PA",
  "es_PY",
  "es_PE",
  "es_PR",
  "es_ES",
  "es_UY",
  "es_VE",
  "uk_UA",
  "ur_PK",
  "ur_IN",
  "uz_UZ",
  "vi_VN",
  "zu_ZA",
  "da_DK",
  "de_AT",
  "de_DE",
  "ar_EG",
  "ar_DZ",
  "ar_BH",
  "ar_AE",
  "ar_IL",
  "ar_JO",
  "ar_KW",
  "ar_LB",
  "ar_MA",
  "ar_OM",
  "ar_PS",
  "ar_QA",
  "ar_TN",
  "ar_SA",
  "cmn_HK",
  "cmn_CN",
  "cmn_TW"
];
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
