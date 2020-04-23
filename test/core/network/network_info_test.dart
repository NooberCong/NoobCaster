import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noobcaster/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockDataConnectionChecker;
  NetworkInfoImpl networkInfo;
  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });
  test("Should forward call to DataConnectionChecker", () {
    final hasConnectionResult = Future.value(true);
    //arrange
    when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => hasConnectionResult);
    //act
    final result = networkInfo.isOnline;
    //assert
    verify(mockDataConnectionChecker.hasConnection);
    expect(result, hasConnectionResult);
  });
}