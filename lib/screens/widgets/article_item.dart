import 'dart:io';

import 'package:flutter/material.dart';
import 'package:newsapp/screens/webviewscreen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:newsapp/models/articles.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatefulWidget {
  final Article item;
  const ArticleItem({Key? key, required this.item}) : super(key: key);

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  bool hovering = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () {
            if (widget.item.url != null) {
              if (!(Platform.isAndroid || Platform.isIOS)) {
                launch(widget.item.url!);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        WebViewScreen(url: widget.item.url!)));
              }
            }
          },
          onHover: (e) => setState(() {
            hovering = e;
          }),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.2),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.item.title ?? 'Not given',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    decoration: hovering
                                        ? TextDecoration.underline
                                        : TextDecoration.none),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Image.network(
                                          widget.item.url!
                                                  .split("/")
                                                  .sublist(0, 3)
                                                  .join("/") +
                                              "/favicon.ico",
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Text(''),
                                        )),
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((widget.item.source ?? '') +
                                            " . " +
                                            timeago.format(
                                              widget.item.publishedAt!,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.item.urlToImage ??
                              "http://52.66.199.213:6969/error",
                          errorBuilder: (context, error, stackTrace) =>
                              Image.network(
                            "http://52.66.199.213:6969/error",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
