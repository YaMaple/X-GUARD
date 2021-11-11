import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import 'algorithm_screen.dart';
import 'report_screen.dart';
import '../models/meal.dart';
import './filters_screen.dart';
import 'news_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals = [];
  static const routeName = '/tab-screen';

  TabsScreen();

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': ReportScreen(),
        'title': 'Report',
      },
      {
        'page': AlgorithmScreen(widget.favoriteMeals),
        'title': 'Algorithm',
      },
      {
        'page': FiltersScreen(),
        'title': 'Filter',
      },
      {
        'page': NewsScreen(),
        'title': 'News',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_pages[_selectedPageIndex]['title']),
      // ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow[400],
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.account_balance),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.attach_money),
            label: 'News',
          ),
        ],
      ),
    );
  }
}
