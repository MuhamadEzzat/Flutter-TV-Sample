import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobileWebView extends StatefulWidget {
  final String url;
  final bool enableJavaScript;
  const MobileWebView(
      {Key? key, required this.url, required this.enableJavaScript})
      : super(key: key);

  @override
  State<MobileWebView> createState() => _MobileWebViewState();
}

class _MobileWebViewState extends State<MobileWebView> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (UniversalPlatform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    //if (UniversalPlatform.isIOS) WebView.platform = CupertinoWebView();

    controller.setJavaScriptMode(widget.enableJavaScript
        ? JavaScriptMode.unrestricted
        : JavaScriptMode.disabled);
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
