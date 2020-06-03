abstract class InputValidator {
  bool validate(String input);
}

class InputValidatorImpl implements InputValidator {
  @override
  bool validate(String input) {
    return input.isNotEmpty;
  }
}
