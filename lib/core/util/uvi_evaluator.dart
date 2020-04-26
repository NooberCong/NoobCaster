String getUviLevel(double rawUvi) {
  if (rawUvi <= 2) {
    return "Low";
  }
  else if (rawUvi <= 5) {
    return "Moderate";
  }
  else if (rawUvi <= 7) {
    return "High";
  }
  else if (rawUvi <= 10) {
    return "Very high";
  }
  return "Extreme";
}