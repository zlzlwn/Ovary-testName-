import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WorkVideoWidget extends StatefulWidget {
  const WorkVideoWidget({super.key});

  @override
  State<WorkVideoWidget> createState() => _WorkVideoWidgetState();
}

class _WorkVideoWidgetState extends State<WorkVideoWidget> {

  late WebViewController controller;
  late bool isLoading;
  late String siteName;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    siteName = 'https://www.youtube.com/results?search_query=%ED%99%88%ED%8A%B8%EC%9A%B4%EB%8F%99';

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          isLoading = true; 
          setState(() {});
        },
        onPageStarted: (url) {
          isLoading = true; 
          setState(() {});
        },
        onPageFinished: (url) {
          isLoading = false; 
          setState(() {});
        },
        onWebResourceError: (error) {
          isLoading = false; 
          setState(() {});
        },
      ) 
    )
    ..loadRequest(Uri.parse(siteName));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoading
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : const Stack(),
        Center(
          child: SizedBox(
            width: 410,
            child: WebViewWidget(controller: controller)
          ),
        )
      ],
    );
  }
}