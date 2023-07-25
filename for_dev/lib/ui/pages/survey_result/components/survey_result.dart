import 'package:flutter/material.dart';

import '../survey_result_viewmodel.dart';
import 'survey_answer.dart';
import 'survey_header.dart';

class SurveyResult extends StatelessWidget {
  final SurveyResultViewModel viewModel;
  final void Function({required String answer}) onSave;

  const SurveyResult({
    super.key,
    required this.viewModel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          return SurveyHeader(question: viewModel.question);
        }

        final answer = viewModel.answers[index - 1];

        return GestureDetector(
          onTap: () =>
              answer.isCurrentAnswer ? null : onSave(answer: answer.answer),
          child: SurveyAnswer(viewModel: answer),
        );
      },
      itemCount: viewModel.answers.length + 1,
    );
  }
}
