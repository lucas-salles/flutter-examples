import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';
import 'surveys_presenter.dart';
import 'survey_viewmodel.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter presenter;

  const SurveysPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
      ),
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        presenter.navigateToStream.listen((page) {
          if (page.isNotEmpty == true) {
            Get.toNamed(page);
          }
        });

        presenter.loadData();

        return StreamBuilder<List<SurveyViewModel>>(
            stream: presenter.surveysStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: snapshot.error as String,
                  reload: presenter.loadData,
                );
              }

              if (snapshot.hasData) {
                return Provider(
                  create: (_) => presenter,
                  child: SurveyItems(snapshot.data!),
                );
              }

              return Container();
            });
      }),
    );
  }
}
