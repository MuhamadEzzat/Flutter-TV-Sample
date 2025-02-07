import 'package:flutter/material.dart';

late int hp, wp, sp, heightPercentage, widthPercentage;

extension SizingExtension on num {
  ///Reduce scale percentage to 35% only
  static const double scaleUpReductionFactor = .35; //35%
  static const double scaleDownReductionFactor = 1; //100%

  ///The reference screen is 5 inches android phone (360*640 LogicalPixels)
  static const Size referenceScreenSize = Size(360, 640);

  double sp(BuildContext context) => _calculateWP(context).toDouble();

  double widthPercentage(BuildContext context) =>
      _calculateWidthPercentage(context).toDouble();

  double heightPercentage(BuildContext context) =>
      _calculateHeightPercentage(context).toDouble();

  double wp(BuildContext context) => _calculateWP(context).toDouble();

  double hp(BuildContext context) => _calculateHP(context).toDouble();

  num _calculateWidthPercentage(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return this / 100 * screenWidth;
  }

  num _calculateHeightPercentage(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return this / 100 * screenHeight;
  }

  num _calculateWP(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double refScreenWidth = _getRefScreenWidth(context);
    double scaleReductionFactor = screenWidth > refScreenWidth
        ? scaleUpReductionFactor
        : scaleDownReductionFactor;
    return (this *
            (1 + (screenWidth / refScreenWidth - 1) * scaleReductionFactor))
        .toDouble();
  }

  ///if current [screenHeight] is less than the [referenceScreenSize.height] ->
  ///reduce the height by the same ratio percentage between them (scaleReductionFactor = 100%).
  ///but if [screenHeight] is greater than ReferenceScreenHeight [referenceScreenSize.height] ->
  ///increase the height by only scaleReductionFactor(35%) of the ratio percentage between them.
  num _calculateHP(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double refScreenHeight = _getRefScreenHeight(context);
    double scaleReductionFactor = screenHeight > refScreenHeight
        ? scaleUpReductionFactor
        : scaleDownReductionFactor;
    return (this *
            (1 + (screenHeight / refScreenHeight - 1) * scaleReductionFactor))
        .toDouble();
  }

  double _getRefScreenWidth(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? referenceScreenSize.shortestSide
        : referenceScreenSize.longestSide;
  }

  double _getRefScreenHeight(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? referenceScreenSize.longestSide
        : referenceScreenSize.shortestSide;
  }
}
