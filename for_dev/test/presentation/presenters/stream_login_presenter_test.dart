import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:for_dev/presentation/protocols/validation.dart';

// Annotation which generates the stream_login_presenter_test.mocks.dart library and the MockValidation class.
@GenerateNiceMocks([MockSpec<Validation>()])
import './stream_login_presenter_test.mocks.dart';

class LoginState {
  String? emailError;
}

class StreamLoginPresenter {
  final Validation validation;

  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({required this.validation});

  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}

void main() {
  late StreamLoginPresenter sut;
  late MockValidation validation;
  late String email;

  PostExpectation mockValidationCall(String? field) => when(validation.validate(
      field: field ?? anyNamed('field'), value: anyNamed('value')));

  void mockValidation({String? field, String? value}) {
    mockValidationCall(field).thenReturn(value);
  }

  setUp(() {
    validation = MockValidation();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', () {
    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');

    expectLater(sut.emailErrorStream, emits('error'));

    sut.validateEmail(email);
  });
}
