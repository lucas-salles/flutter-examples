import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
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
                return ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        padding: const EdgeInsets.only(
                          top: 40,
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).disabledColor.withAlpha(90),
                        ),
                        child:
                            const Text('Qual é o seu framework web favorito?'),
                      );
                    }
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  'https://pbs.twimg.com/profile_images/446356636710363136/OYIaJ1KK_400x400.png',
                                  width: 40,
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'React',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                Text(
                                  '100%',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 1)
                      ],
                    );
                  },
                  itemCount: 4,
                );
              }

              return Container();
            });
      }),
    );
  }
}
