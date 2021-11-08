import 'package:animation/screens/home/widgets/list_data.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSlidePosition;

  const AnimatedListView({Key? key, required this.listSlidePosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListData(
          title: "Estudar Flutter",
          subtitle: "Com o curso do Flutter Brasil",
          image: NetworkImage("https://github.com/lucas-salles.png"),
          margin: listSlidePosition.value * 2,
        ),
        ListData(
          title: "Estudar Flutter",
          subtitle: "Com o curso do Flutter Brasil",
          image: NetworkImage("https://github.com/lucas-salles.png"),
          margin: listSlidePosition.value * 1,
        ),
        ListData(
          title: "Estudar Flutter",
          subtitle: "Com o curso do Flutter Brasil",
          image: NetworkImage("https://github.com/lucas-salles.png"),
          margin: listSlidePosition.value * 0,
        ),
      ],
    );
  }
}
