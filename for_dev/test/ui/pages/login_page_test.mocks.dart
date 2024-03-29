// Mocks generated by Mockito 5.4.0 from annotations
// in for_dev/test/ui/pages/login_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:for_dev/ui/helpers/errors/ui_error.dart' as _i4;
import 'package:for_dev/ui/pages/login/login_presenter.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [LoginPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginPresenter extends _i1.Mock implements _i2.LoginPresenter {
  @override
  _i3.Stream<_i4.UIError?> get emailErrorStream => (super.noSuchMethod(
        Invocation.getter(#emailErrorStream),
        returnValue: _i3.Stream<_i4.UIError?>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.UIError?>.empty(),
      ) as _i3.Stream<_i4.UIError?>);
  @override
  _i3.Stream<_i4.UIError?> get passwordErrorStream => (super.noSuchMethod(
        Invocation.getter(#passwordErrorStream),
        returnValue: _i3.Stream<_i4.UIError?>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.UIError?>.empty(),
      ) as _i3.Stream<_i4.UIError?>);
  @override
  _i3.Stream<_i4.UIError?> get mainErrorStream => (super.noSuchMethod(
        Invocation.getter(#mainErrorStream),
        returnValue: _i3.Stream<_i4.UIError?>.empty(),
        returnValueForMissingStub: _i3.Stream<_i4.UIError?>.empty(),
      ) as _i3.Stream<_i4.UIError?>);
  @override
  _i3.Stream<String?> get navigateToStream => (super.noSuchMethod(
        Invocation.getter(#navigateToStream),
        returnValue: _i3.Stream<String?>.empty(),
        returnValueForMissingStub: _i3.Stream<String?>.empty(),
      ) as _i3.Stream<String?>);
  @override
  _i3.Stream<bool> get isValidFormStream => (super.noSuchMethod(
        Invocation.getter(#isValidFormStream),
        returnValue: _i3.Stream<bool>.empty(),
        returnValueForMissingStub: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);
  @override
  _i3.Stream<bool> get isLoadingStream => (super.noSuchMethod(
        Invocation.getter(#isLoadingStream),
        returnValue: _i3.Stream<bool>.empty(),
        returnValueForMissingStub: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);
  @override
  void validateEmail(String? email) => super.noSuchMethod(
        Invocation.method(
          #validateEmail,
          [email],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void validatePassword(String? password) => super.noSuchMethod(
        Invocation.method(
          #validatePassword,
          [password],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Future<void> auth() => (super.noSuchMethod(
        Invocation.method(
          #auth,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  void goToSignUp() => super.noSuchMethod(
        Invocation.method(
          #goToSignUp,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
