import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';

import '../dummy_data.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  NewsScreen();

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String categoryTitle = 'HJO Test';
  var _loadedInitData = true;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      // final categoryId = routeArgs['id'];
      // displayedMeals = widget.availableMeals.where((meal) {
      //   return meal.categories.contains(categoryId);
      // }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return NewsItem(
            index: DUMMY_NEWS[index].index,
            title: DUMMY_NEWS[index].title,
            imageUrl: DUMMY_NEWS[index].imageUrl,
            content: DUMMY_NEWS[index].content,
          );
        },
        itemCount: DUMMY_NEWS.length,
      ),
    );
  }
}
