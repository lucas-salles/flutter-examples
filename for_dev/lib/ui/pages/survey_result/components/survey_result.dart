import 'package:flutter/material.dart';

import '../survey_result_viewmodel.dart';
import 'survey_answer.dart';
import 'survey_header.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;

  const SurveyResult(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(question: viewModel.question);
        }
        return SurveyAnswer(viewModel: viewModel.answers[index - 1]);
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
