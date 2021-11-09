import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

import '../dummy_data.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  List<Meal> availableMeals = DUMMY_MEALS;

  NewsScreen();

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String categoryTitle = 'HJO Test';
  List<Meal> displayedMeals = DUMMY_MEALS;
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
      displayedMeals = widget.availableMeals;
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus'),
        backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
