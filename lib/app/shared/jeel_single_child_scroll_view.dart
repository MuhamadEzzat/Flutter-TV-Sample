import 'dart:math';

import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../core/values/app_assets.dart';

class JeelSingleChildScrollView extends StatefulWidget {
  final Widget child;
  final bool enableScrollableIcon;
  final ScrollController? scrollController;

  final Alignment alignment;

  const JeelSingleChildScrollView({
    required this.child,
    this.enableScrollableIcon = true,
    this.alignment = Alignment.center,
    this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  _JeelSingleChildScrollViewState createState() =>
      _JeelSingleChildScrollViewState();
}

class _JeelSingleChildScrollViewState extends State<JeelSingleChildScrollView> {
  ScrollController scrollController = ScrollController();

  bool isScrollableUp = false;
  bool isScrollableDown = false;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
    if (widget.enableScrollableIcon && !UniversalPlatform.isWeb) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _updateIsScrollable();
        });
      });
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _updateIsScrollable();
        });
      });
      scrollController.addListener(_updateIsScrollable);
    }
  }

  _updateIsScrollable() {
    if (!isDisposed) {
      setState(() {
        if (scrollController.position.pixels < 10) {
          isScrollableUp = false;
        } else {
          isScrollableUp = true;
        }
        if (scrollController.position.pixels >
            scrollController.position.maxScrollExtent - 10) {
          isScrollableDown = false;
        } else {
          isScrollableDown = true;
        }
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Stack(
        alignment: widget.alignment,
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            child: widget.child,
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: isScrollableUp ? 1 : 0,
              duration: const Duration(milliseconds: 700),
              child: const Align(
                alignment: Alignment.topCenter,
                child: BuildArrow(),
              ),
            ),
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              opacity: isScrollableDown ? 1 : 0,
              duration: const Duration(milliseconds: 700),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Transform.rotate(
                  angle: 180 * pi / 180,
                  child: const BuildArrow(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuildArrow extends StatelessWidget {
  const BuildArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 1),
          )
        ],
        color: Colors.deepPurple.withOpacity(.3),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(360),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 26, right: 26, bottom: 8, top: 6),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white30,
        ),
        height: 38,
        child: Image.asset(AppAssets.kScrollArrowUp),
      ),
    );
  }
}
