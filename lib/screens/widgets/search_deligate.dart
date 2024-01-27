import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/models/articles.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screens/widgets/news/article_item.dart';
import 'package:provider/provider.dart';

class NewsSearch extends SearchDelegate {
  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_left));

  List<Article> resdecoder(res) {
    return (res["articles"] as List)
        .map((a) => Article(
            (a['source'] as Map)['name'],
            a['author'],
            a['title'],
            a['description'],
            a['url'],
            a['urlToImage'],
            DateTime.tryParse(a['publishedAt']),
            a['content']))
        .toList();
  }

  Future<List<Article>> fetch_stores_based_using_query(String query) async {
    var head = {
      "Accept": "*/*",
      "Content-type": "application/json",
      "User-Agent": "News app"
    };

    String q = query.trim().replaceAll(" ", "+");

    Future<http.Response> data1 = (http.get(
        Uri.parse(
            "https://newsapi.org/v2/everything?q=$q&apiKey=20d99f327ed747cfae3d76aa38294007"),
        headers: head));
    Future<http.Response> data2 = (http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?q=$q&apiKey=20d99f327ed747cfae3d76aa38294007"),
        headers: head));

    var res = jsonDecode((await data1).body) as Map;
    List<Article> a = resdecoder(res);
    res = jsonDecode((await data2).body) as Map;
    List<Article> b = resdecoder(res);

    return [...a, ...b];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [
        if (query == '')
          const Expanded(
              child: Text(
            "Recent Stores",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
        if (query == '')
          Expanded(
            flex: 15,
            child: ListView.builder(
              itemCount: Provider.of<NP>(context)
                  .stories!
                  .AllNews
                  .firstWhere(
                      (NewsCategory element) => element.category == "general")
                  .stories
                  .length,
              itemBuilder: (context, index) {
                var item = Provider.of<NP>(context)
                    .stories!
                    .AllNews
                    .firstWhere(
                        (NewsCategory element) => element.category == "general")
                    .stories
                    .elementAt(index);
                return ArticleItem(item: item);
              },
            ),
          ),
        if (query != "")
          Expanded(
            child: FutureBuilder(
                future: fetch_stores_based_using_query(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                        itemCount: (snapshot.data as List<Article>).length,
                        itemBuilder: (context, index) => ArticleItem(
                            item: (snapshot.data as List<Article>)
                                .elementAt(index)));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
      ],
    );
  }

  Widget articles(query) => Expanded(
        child: FutureBuilder(
            future: fetch_stores_based_using_query(query),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                    itemCount: (snapshot.data as List<Article>).length,
                    itemBuilder: (context, index) => ArticleItem(
                        item:
                            (snapshot.data as List<Article>).elementAt(index)));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      );

  @override
  Widget buildResults(BuildContext context) => articles(query);

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        if (query != "")
          IconButton(
              onPressed: () {
                query = "";
              },
              icon: const Icon(Icons.cancel))
      ];
}
