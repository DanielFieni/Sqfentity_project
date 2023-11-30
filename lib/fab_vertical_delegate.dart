import 'package:flutter/material.dart';

class FabVerticalDelegate extends FlowDelegate {
  final AnimationController animationController;

  FabVerticalDelegate({required this.animationController}) : super(repaint: animationController);

  @override
  void paintChildren(FlowPaintingContext context) {
    const buttonSize = 56;
    const buttonRadius = buttonSize / 2;
    const buttonMargin = 10;

    final positionX = context.size.width - buttonSize;
    final positionY = context.size.height - buttonSize;
    final lastIndex = context.childCount - 1;

    for(int i = lastIndex; i >= 0; i--) {
      final y = positionY - ((buttonSize + buttonMargin) * i * animationController.value);
      final size = (i != 0) ? animationController.value : 1.0;

      context.paintChild(
        i, 
        transform: Matrix4.translationValues(positionX, y, 0)
          ..translate(buttonRadius, buttonRadius)
          ..scale(size)
          ..translate(-buttonRadius, -buttonRadius)
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}