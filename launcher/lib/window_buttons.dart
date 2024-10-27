import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'theme.dart';

final buttonColors = WindowButtonColors(
    mouseOver: MainTheme.mouseOver,
    mouseDown: MainTheme.mouseDown,
    iconNormal: MainTheme.iconNormal,
    iconMouseOver: MainTheme.iconMouseOver,
    iconMouseDown: MainTheme.iconMouseDown);

final closeButtonColors = WindowButtonColors(
    mouseOver: MainTheme.closeBtnMouseOver,
    mouseDown: MainTheme.closeBtnMouseDown,
    iconNormal: MainTheme.closeBtnIconNormal,
    iconMouseOver: MainTheme.closeBtnIconMouseOver,
    iconMouseDown: MainTheme.closeBtnIconMouseDown);

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
