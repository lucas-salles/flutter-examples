// Mocks generated by Mockito 5.4.0 from annotations
// in for_dev/test/main/composites/remote_load_survey_result_with_local_fallback_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:for_dev/data/http/http.dart' as _i2;
import 'package:for_dev/data/usecases/load_survey_result/remote_load_survey_result.dart'
    as _i4;
import 'package:for_dev/domain/entities/entities.dart' as _i3;
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

class _FakeHttpClient_0 extends _i1.SmartFake implements _i2.HttpClient {
  _FakeHttpClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSurveyResultEntity_1 extends _i1.SmartFake
    implements _i3.SurveyResultEntity {
  _FakeSurveyResultEntity_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RemoteLoadSurveyResult].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteLoadSurveyResult extends _i1.Mock
    implements _i4.RemoteLoadSurveyResult {
  @override
  String get url => (super.noSuchMethod(
        Invocation.getter(#url),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i2.HttpClient get httpClient => (super.noSuchMethod(
        Invocation.getter(#httpClient),
        returnValue: _FakeHttpClient_0(
          this,
          Invocation.getter(#httpClient),
        ),
        returnValueForMissingStub: _FakeHttpClient_0(
          this,
          Invocation.getter(#httpClient),
        ),
      ) as _i2.HttpClient);
  @override
  _i5.Future<_i3.SurveyResultEntity> loadBySurvey({String? surveyId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadBySurvey,
          [],
          {#surveyId: surveyId},
        ),
        returnValue:
            _i5.Future<_i3.SurveyResultEntity>.value(_FakeSurveyResultEntity_1(
          this,
          Invocation.method(
            #loadBySurvey,
            [],
            {#surveyId: surveyId},
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.SurveyResultEntity>.value(_FakeSurveyResultEntity_1(
          this,
          Invocation.method(
            #loadBySurvey,
            [],
            {#surveyId: surveyId},
          ),
        )),
      ) as _i5.Future<_i3.SurveyResultEntity>);
}