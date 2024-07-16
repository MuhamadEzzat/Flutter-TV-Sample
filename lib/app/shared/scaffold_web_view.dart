import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:universal_platform/universal_platform.dart';

import '../core/values/app_colors.dart';
import 'jeel_app_bar.dart';
import 'mobile_web_view.dart';

class ScaffoldWebView extends StatefulWidget {
  const ScaffoldWebView({
    required this.url,
    required this.appBarTitle,
    this.botNavBar,
    this.enableJavaScript = false,
    this.showHelpIcon = false,
    this.hideAppBar = false,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);
  final Widget? botNavBar;
  final String url, appBarTitle;
  final bool enableJavaScript, showHelpIcon, hideAppBar;
  final Color? backgroundColor;

  @override
  State<ScaffoldWebView> createState() => _ScaffoldWebViewState();
}

class _ScaffoldWebViewState extends State<ScaffoldWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hideAppBar
          ? null
          : JeelAppBar(
              title: widget.appBarTitle,
              showHelpIcon: widget.showHelpIcon,
              backgroundColor: widget.backgroundColor ?? AppColors.newPurple,
            ),
      body: MobileWebView(
        url: widget.url,
        enableJavaScript: widget.enableJavaScript,
      ),

      // InAppWebView(
      //         key: webViewKey,
      //         // initialUrlRequest: URLRequest(url: Uri.tryParse(widget.url)),
      //         initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      //         onWebViewCreated: (controller) async {
      //           webViewController = controller;
      //         },
      //       )


    );
  }
}
