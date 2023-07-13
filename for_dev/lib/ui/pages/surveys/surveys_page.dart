import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import '../../helpers/helpers.dart';

import 'surveys_presenter.dart';

class SurveysPage extends StatelessWidget {
  final SurveysPresenter? presenter;

  const SurveysPage(this.presenter, {super.key});

  @override
  Widget build(BuildContext context) {
    presenter?.loadData();

    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.surveys),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CarouselSlider(
          options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 1),
          items: const [
            SurveyItem(),
            SurveyItem(),
          ],
        ),
      ),
    );
  }
}
