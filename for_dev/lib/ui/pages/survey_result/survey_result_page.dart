import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';
import 'survey_result_presenter.dart';

class SurveyResultPage extends StatelessWidget {
  final SurveyResultPresenter? presenter;

  const SurveyResultPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
      ),
      body: Builder(builder: (context) {
        presenter?.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        presenter?.loadData();

        return StreamBuilder<dynamic>(
            stream: presenter?.surveyResultStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: snapshot.error as String,
                  reload: presenter!.loadData,
                );
              }

              if (snapshot.hasData) {
                return const SurveyResult();
              }

              return Container();
            });
      }),
    );
  }
}
