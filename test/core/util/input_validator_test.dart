import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/core/util/input_validator.dart';

void main() {
  InputValidator inputValidator;
  setUp(() {
    inputValidator = InputValidator();
  });
  test('Should return false when string is empty', () {
    //act
    final result = inputValidator.validate("");
    //assert
    expect(result, false);
  });
  test('Should return true when string is not empty', () {
    //act
    final result = inputValidator.validate("Test String");
    //assert
    expect(result, true);
  });
}