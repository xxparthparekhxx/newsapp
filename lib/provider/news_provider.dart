import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/models/articles.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NP with ChangeNotifier {
  final String _top = "top-headlines?";

  final List<String> categories = [
    "top_stories",
    "general",
    "world",
    "business",
    "technology",
    "entertainment",
    "sports",
    "science",
    "health",
  ];
  News? stories;

  int screenindex = 0;
  NP() {
    get_data_from_db();
  }

  Future fetch_all(SharedPreferences prefs, int pageSize) async {
    List<Future> requests =
        categories.map((e) => fetch_stories(e, pageSize)).toList();

    for (int i = 0; i < categories.length; i++) {
      await prefs.setString(categories[i], await requests[i]);
    }
    await prefs.setString("LastUpdated", DateTime.now().toString());
  }

  News make_news(SharedPreferences prefs) {
    return News(categories.map((e) {
      var CurrentArticles = prefs.get(e);
      CurrentArticles = jsonDecode(CurrentArticles! as String);
      return NewsCategory.fromjson(
          e, ((CurrentArticles! as Map)['articles'] as List));
    }).toList());
  }

  get_data_from_db() async {
    final prefs = await SharedPreferences.getInstance(); //get sorage ref
    String? lastUpdatedTime = prefs.get("LastUpdated") as String?;
    int pageSize = 100;
    if (lastUpdatedTime == null) {
      //if new device
      await fetch_all(prefs, pageSize);
      stories = make_news(prefs);
      prefs.setString(
          "LastUpdated", DateTime.now().microsecondsSinceEpoch.toString());
    } else {
      //if last updated time is more then one hour ago then update else get the old data;
      final lastupdated =
          DateTime.fromMicrosecondsSinceEpoch(int.parse(lastUpdatedTime));
      bool isolderthenonehour =
          DateTime.now().compareTo(lastupdated.add(const Duration(hours: 1))) ==
              1;

      if (!isolderthenonehour) {
        stories = make_news(prefs);
      } else {
        await fetch_all(prefs, pageSize);
        stories = make_news(prefs);
        prefs.setString(
            "LastUpdated", DateTime.now().microsecondsSinceEpoch.toString());
      }
    }
    notifyListeners();
  }

  Future<String> fetch_stories(String? category, int pageSize) async {
    String payload =
        "$_top${(category != "top_stories" && category != "world" ? "category=$category&" : "")}${(category == "world" ? "language=en&pageSize=100" : "country=in&pageSize=100")}";
    var body = jsonEncode({"endpoint": payload});
    String data = (await http
            .post(Uri.parse("http://52.66.199.213:6969"), body: body, headers: {
      "Accept": "*/*",
      "Content-type": "application/json",
      "User-Agent": "News app by https://github.com/xxparthparekhxx"
    }))
        .body;
    return data;
  }

  setindex(int index) {
    screenindex = index;
    notifyListeners();
  }
}
