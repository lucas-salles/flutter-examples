// Mocks generated by Mockito 5.4.0 from annotations
// in for_dev/test/presentation/presenters/getx_survey_result_presenter_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:for_dev/domain/entities/entities.dart' as _i2;
import 'package:for_dev/domain/usecases/load_survey_result.dart' as _i3;
import 'package:for_dev/domain/usecases/save_survey_result.dart' as _i5;
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

class _FakeSurveyResultEntity_0 extends _i1.SmartFake
    implements _i2.SurveyResultEntity {
  _FakeSurveyResultEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoadSurveyResult].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoadSurveyResult extends _i1.Mock implements _i3.LoadSurveyResult {
  @override
  _i4.Future<_i2.SurveyResultEntity> loadBySurvey(
          {required String? surveyId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #loadBySurvey,
          [],
          {#surveyId: surveyId},
        ),
        returnValue:
            _i4.Future<_i2.SurveyResultEntity>.value(_FakeSurveyResultEntity_0(
          this,
          Invocation.method(
            #loadBySurvey,
            [],
            {#surveyId: surveyId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.SurveyResultEntity>.value(_FakeSurveyResultEntity_0(
          this,
          Invocation.method(
            #loadBySurvey,
            [],
            {#surveyId: surveyId},
          ),
        )),
      ) as _i4.Future<_i2.SurveyResultEntity>);
}

/// A class which mocks [SaveSurveyResult].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveSurveyResult extends _i1.Mock implements _i5.SaveSurveyResult {
  @override
  _i4.Future<_i2.SurveyResultEntity> save({required String? answer}) =>
      (super.noSuchMethod(
        Invocation.method(
          #save,
          [],
          {#answer: answer},
        ),
        returnValue:
            _i4.Future<_i2.SurveyResultEntity>.value(_FakeSurveyResultEntity_0(
          this,
          Invocation.method(
            #save,
            [],
            {#answer: answer},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.SurveyResultEntity>.value(_FakeSurveyResultEntity_0(
          this,
          Invocation.method(
            #save,
            [],
            {#answer: answer},
          ),
        )),
      ) as _i4.Future<_i2.SurveyResultEntity>);
}
