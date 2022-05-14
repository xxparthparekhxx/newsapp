import 'package:flutter/material.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NP(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        title: 'Material App',
        home: const Home(),
      ),
    );
  }
}
