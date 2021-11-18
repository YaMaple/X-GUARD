import 'package:flutter/material.dart';
import 'constants.dart';

import '../dummy_data.dart';

class NewsDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  NewsDetailScreen();

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
    final newsId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(DUMMY_NEWS[newsId].title),
        backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
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
                image: AssetImage(DUMMY_NEWS[newsId].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(DUMMY_NEWS[newsId].title,
                style: kTitleCard.copyWith(fontSize: 28.0)),
            SizedBox(
              height: 12.0,
            ),
            Text(
              DUMMY_NEWS[newsId].content,
              style: descriptionStyle,
            )
          ],
        ),
      ),
    );
  }
}
