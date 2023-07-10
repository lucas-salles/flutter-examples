// Mocks generated by Mockito 5.4.0 from annotations
// in for_dev/test/presentation/presenters/getx_signup_presenter_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:for_dev/presentation/protocols/validation.dart' as _i2;
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

/// A class which mocks [Validation].
///
/// See the documentation for Mockito's code generation for more information.
class MockValidation extends _i1.Mock implements _i2.Validation {
  @override
  _i2.ValidationError? validate({
    required String? field,
    required String? value,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #validate,
          [],
          {
            #field: field,
            #value: value,
          },
        ),
        returnValueForMissingStub: null,
      ) as _i2.ValidationError?);
}
