abstract class InputValidator {
  bool validate(String input);
}

class InputValidatorImpl implements InputValidator {
  bool validate(String input) {
    return input.length > 0;
  }
}
