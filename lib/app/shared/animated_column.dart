import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'jeel_single_child_scroll_view.dart';


class AnimatedColumn extends StatelessWidget {
  final List<Widget> children;
  final Alignment alignment;
  final ScrollController? scrollController;
  final CrossAxisAlignment crossAxisAlignment;
  final bool enableScrollableIcon;

  const AnimatedColumn({
    Key? key,
    required this.children,
    this.scrollController,
    this.alignment = Alignment.center,
    this.enableScrollableIcon = true,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JeelSingleChildScrollView(
      scrollController: scrollController,
      enableScrollableIcon: enableScrollableIcon,
      alignment: alignment,
      child: AnimationLimiter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      ),
    );
  }
}
