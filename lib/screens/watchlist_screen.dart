import 'package:flutter/material.dart';

class CardDetail {
  String title;
  String subtitle_1;
  String subtitle_2;

  CardDetail(
      {required this.title,
      required this.subtitle_1,
      required this.subtitle_2});
}

class CardListTile extends StatelessWidget {
  final String title;
  final String subtitle_1;
  final String subtitle_2;

  CardListTile(
      {required this.title,
      required this.subtitle_1,
      required this.subtitle_2});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      color: Colors.white,
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1.0,
                color: Colors.black,
              ),
            ),
          ),
          child: Text(
            'High Risk',
            style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.red,
                fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow[900],
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[900],
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[900],
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[900],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subtitle_1,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              subtitle_2,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
          size: 30.0,
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/algorithm', arguments: 1);
        },
      ),
    );
  }
}

class WatchListScreen extends StatelessWidget {
  static const routeName = '/filters';

  final List<CardDetail> cards = [
    CardDetail(title: 'Meta', subtitle_1: '\$200,000', subtitle_2: '2017'),
    CardDetail(title: 'LinkedIn', subtitle_1: '\$30,000', subtitle_2: '2018'),
    CardDetail(title: 'Amazon', subtitle_1: '\$15,000', subtitle_2: '2019'),
    CardDetail(title: 'Google', subtitle_1: '\$80,0000', subtitle_2: '2021'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch List'),
        backgroundColor: Color.fromARGB(0xff, 0x14, 0x27, 0x4e),
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) => CardListTile(
          title: cards[index].title,
          subtitle_1: cards[index].subtitle_1,
          subtitle_2: cards[index].subtitle_2,
        ),
      ),
    );
  }
}
