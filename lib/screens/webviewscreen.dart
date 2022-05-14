import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  double progress = 0;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark)),
          IconButton(
              onPressed: () => Share.share(widget.url),
              icon: const Icon(Icons.share))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: LinearProgressIndicator(
            value: progress,
          )),
          Expanded(
            flex: 99,
            child: Material(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onProgress: (i) {
                  setState(() {
                    progress = i / 100;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
