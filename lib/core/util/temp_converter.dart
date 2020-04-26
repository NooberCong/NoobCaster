String toCelcius(double rawTemp) {
  return "${(rawTemp - 273.15).round()}°C";
}

String toFahrenheit(double rawTemp) {
  return "${((rawTemp - 273.15) * 9 / 5).round() + 32}°F";
}