import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {
  final int centralFlex;
  final Widget centralWidget;
  final CrossAxisAlignment myCrossAxisAlignment;
  final MainAxisAlignment myMainAxisAlignment;
  MyRow({
    this.centralFlex,
    this.centralWidget,
    this.myCrossAxisAlignment,
    this.myMainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: myCrossAxisAlignment != null
          ? myCrossAxisAlignment
          : CrossAxisAlignment.center,
      mainAxisAlignment: myMainAxisAlignment != null
          ? myMainAxisAlignment
          : MainAxisAlignment.start,
      children: [
        Expanded(child: Container()),
        Expanded(flex: centralFlex, child: centralWidget),
        Expanded(child: Container()),
      ],
    );
  }
}
