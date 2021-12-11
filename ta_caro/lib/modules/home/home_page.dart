import 'package:flutter/material.dart';
import 'package:ta_caro/modules/create/create_bottom_sheet.dart';
import 'package:ta_caro/shared/models/user_model.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/bottom_navigator/app_bottom_navigator.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  final List<Widget> pages;

  const HomePage({
    Key? key,
    required this.user,
    required this.pages,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late final List<Widget> pages = widget.pages;

  void changeIndex(int index) async {
    if (index == 3) {
      await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => const CreateBottomSheet(),
      );
    } else {
      currentIndex = index;
    }
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              key: UniqueKey(),
              child: List.from(pages)[currentIndex],
            ),
            Positioned(
              bottom: 14,
              left: 26,
              right: 26,
              child: AppBottomNavigator(
                currrentIndex: currentIndex,
                onChanged: changeIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
