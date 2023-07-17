// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Annotation which generates the local_storage_adapter_test.mocks.dart library and the MockLocalStorage class.
@GenerateNiceMocks([MockSpec<LocalStorage>()])
import './local_storage_adapter_test.mocks.dart';

class LocalStorageAdapter {
  final LocalStorage localStorage;

  LocalStorageAdapter({required this.localStorage});

  Future<void> save({required String key, required dynamic value}) async {
    await localStorage.setItem(key, value);
  }
}

void main() {
  test('Should call localStorage with correct values', () async {
    final key = faker.randomGenerator.string(5);
    final value = faker.randomGenerator.string(50);
    final localStorage = MockLocalStorage();
    final sut = LocalStorageAdapter(localStorage: localStorage);

    await sut.save(key: key, value: value);

    verify(localStorage.setItem(key, value)).called(1);
  });
}
