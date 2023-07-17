import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/infra/cache/cache.dart';

// Annotation which generates the local_storage_adapter_test.mocks.dart library and the MockLocalStorage class.
@GenerateNiceMocks([MockSpec<LocalStorage>()])
import './local_storage_adapter_test.mocks.dart';

void main() {
  late String key;
  late dynamic value;
  late MockLocalStorage localStorage;
  late LocalStorageAdapter sut;

  void mockDeleteError() =>
      when(localStorage.deleteItem(any)).thenThrow(Exception());

  void mockSaveError() =>
      when(localStorage.setItem(any, any)).thenThrow(Exception());

  setUp(() {
    key = faker.randomGenerator.string(5);
    value = faker.randomGenerator.string(50);
    localStorage = MockLocalStorage();
    sut = LocalStorageAdapter(localStorage: localStorage);
  });

  test('Should call localStorage with correct values', () async {
    await sut.save(key: key, value: value);

    verify(localStorage.deleteItem(key)).called(1);
    verify(localStorage.setItem(key, value)).called(1);
  });

  test('Should throw if deleteItem throws', () async {
    mockDeleteError();

    final future = sut.save(key: key, value: value);

    expect(future, throwsA(const TypeMatcher<Exception>()));
  });

  test('Should throw if setItem throws', () async {
    mockSaveError();

    final future = sut.save(key: key, value: value);

    expect(future, throwsA(const TypeMatcher<Exception>()));
  });
}
