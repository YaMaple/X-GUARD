import 'package:flutter/material.dart';
import 'constants.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 15),
              height: 300,
              // decoration: BoxDecoration(
              //   border: Border.all(color: kGrey3, width: 1.0),
              //   borderRadius: BorderRadius.circular(25.0),
              // ),
              child: Image(
                image: AssetImage(selectedMeal.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text("My Title,", style: kTitleCard.copyWith(fontSize: 28.0)),
            SizedBox(
              height: 12.0,
            ),
            Text(
              '''The history of modern finance is littered with ideas that worked well enough at small scale—railway bonds, Japanese skyscrapers, sliced-and-diced mortgage securities—but morphed into monstrosities once too many punters piled in. When it comes to sheer size, no mania can compare with that for passive investing. Funds that track the entire market by buying shares in every company in America’s s&p 500, say, rather than guessing which will perform better than average, have attained giant scale. Fully 40% of the total net assets managed by funds in America are in passive vehicles, reckons the Investment Company Institute, an industry group. The phenomenon warrants scrutiny.

Index funds have grown because of the validity of the core insight underpinning them: conventional investment funds are, by and large, a terrible proposition. The vast majority fail to beat the market over the years. Hefty management fees paid by investors in such ventures, often around 1-2% a year (and more for snazzy hedge funds), add up to giant bonuses for stockpickers. Index funds, by contrast, charge nearly nothing (0.04% for a large equity fund) and do a good job of hugging their chosen benchmark. Given time, they almost inevitably leave active managers in the dust.''',
              style: descriptionStyle,
            )
          ],
        ),
      ),
    );
  }
}
