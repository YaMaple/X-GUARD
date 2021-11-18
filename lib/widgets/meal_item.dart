import 'package:flutter/material.dart';

import '../screens/news_detail_screen.dart';
import '../models/news.dart';

class NewsItem extends StatelessWidget {
  final int index;
  final String title;
  final String imageUrl;
  final String content;

  NewsItem(
      {required this.index,
      required this.title,
      required this.imageUrl,
      required this.content});

  void ClickNews(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      NewsDetailScreen.routeName,
      arguments: index,
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ClickNews(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage(imageUrl),
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                    ),
                    // softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
