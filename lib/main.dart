import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/provider/news_provider.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:newsapp/screens/home.dart';
import 'package:provider/provider.dart';

void main() => {
      runApp(const MyApp()),
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.amber,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarContrastEnforced: true))
    };

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NP(),
        ),
        ChangeNotifierProvider(
          create: (context) => WP(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        title: 'News App',
        home: const Home(),
      ),
    );
  }
}
