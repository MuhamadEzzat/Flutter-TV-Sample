import 'package:flutter/material.dart';

import '../core/values/app_assets.dart';

class ChildLoadingWidget extends StatelessWidget {
  const ChildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.kChildLoading,
      fit: BoxFit.contain,
    );
  }
}
