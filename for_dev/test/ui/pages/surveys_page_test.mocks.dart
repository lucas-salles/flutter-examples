// Mocks generated by Mockito 5.4.0 from annotations
// in for_dev/test/ui/pages/surveys_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:for_dev/ui/pages/surveys/survey_view_model.dart' as _i4;
import 'package:for_dev/ui/pages/surveys/surveys_presenter.dart' as _i2;
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

/// A class which mocks [SurveysPresenter].
///
/// See the documentation for Mockito's code generation for more information.
class MockSurveysPresenter extends _i1.Mock implements _i2.SurveysPresenter {
  @override
  _i3.Stream<bool> get isLoadingStream => (super.noSuchMethod(
        Invocation.getter(#isLoadingStream),
        returnValue: _i3.Stream<bool>.empty(),
        returnValueForMissingStub: _i3.Stream<bool>.empty(),
      ) as _i3.Stream<bool>);
  @override
  _i3.Stream<List<_i4.SurveyViewModel>> get loadSurveysStream =>
      (super.noSuchMethod(
        Invocation.getter(#loadSurveysStream),
        returnValue: _i3.Stream<List<_i4.SurveyViewModel>>.empty(),
        returnValueForMissingStub:
            _i3.Stream<List<_i4.SurveyViewModel>>.empty(),
      ) as _i3.Stream<List<_i4.SurveyViewModel>>);
  @override
  _i3.Future<void> loadData() => (super.noSuchMethod(
        Invocation.method(
          #loadData,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
