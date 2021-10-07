import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  FavoritesScreenState createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    print("submit data");
    print(titleController.text);
    print(amountController.text);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Favorites'),
          ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  onSubmitted: (_) => submitData(),
                ),
              ],
            ),
          ));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: widget.favoriteMeals[index].id,
            title: widget.favoriteMeals[index].title,
            imageUrl: widget.favoriteMeals[index].imageUrl,
            duration: widget.favoriteMeals[index].duration,
            affordability: widget.favoriteMeals[index].affordability,
            complexity: widget.favoriteMeals[index].complexity,
          );
        },
        itemCount: widget.favoriteMeals.length,
      );
    }
  }
}
