String formatDescription(String rawDesc) {
  return rawDesc.split(" ").map((word) => _capitalize(word)).toList().join(" ");
}

String _capitalize(String word) {
  return word[0].toUpperCase() + word.substring(1,);
}