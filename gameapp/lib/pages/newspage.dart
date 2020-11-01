import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  final String newsUrl;
  NewsPage({this.newsUrl});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(children: [
          WebView(
            onPageFinished: (val) => setState(()=>isLoading=false),
            // onWebViewCreated: (val) => setState(()=>isLoading=true),
            
            initialUrl: widget.newsUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          isLoading?Container(
            color: Colors.black54,
            child: Center(
              child:CircularProgressIndicator()),
          ):Stack()
        ]));
  }
}
