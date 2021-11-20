import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/algorithm_screen.dart';
import 'package:flutter_complete_guide/screens/easter_egg_screen.dart';

import 'screens/tabs_screen.dart';
import 'screens/news_detail_screen.dart';
import 'screens/news_screen.dart';
import 'screens/watchlist_screen.dart';
import 'screens/profile.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/signup_screen.dart';
import 'screens/easter_egg_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
        canvasColor: Color.fromARGB(0xff, 0xff, 0xff, 0xff),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            subtitle1: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        '/': (ctx) => TabsScreen(),
        NewsScreen.routeName: (ctx) => NewsScreen(),
        NewsDetailScreen.routeName: (ctx) => NewsDetailScreen(),
        WatchListScreen.routeName: (ctx) => WatchListScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        AlgorithmScreen.routeName: (ctx) => AlgorithmScreen(),
        EasterEggScreen.routeName: (ctx) => EasterEggScreen()
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        return MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => LoginScreen(),
        );
      },
    );
  }
}
