import 'package:flutter/material.dart';

import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/icon_bottom_navigator/icon_bottom_navigator.dart';

class AppBottomNavigator extends StatelessWidget {
  final int currrentIndex;
  final ValueChanged<int> onChanged;

  const AppBottomNavigator({
    Key? key,
    required this.currrentIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 26, left: 26, bottom: 14),
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: AppTheme.colors.textEnabled,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconBottomNavigator(
              onTap: () {
                onChanged(0);
              },
              enabled: currrentIndex == 0,
              icon: Icons.home,
            ),
            IconBottomNavigator(
              onTap: () {
                onChanged(3);
              },
              enabled: false,
              icon: Icons.add,
            ),
            IconBottomNavigator(
              onTap: () {
                onChanged(1);
              },
              enabled: currrentIndex == 1,
              icon: Icons.settings,
            ),
          ],
        ),
      ),
    );
  }
}
