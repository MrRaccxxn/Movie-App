import 'package:flutter/material.dart';
import 'package:movie_app/src/components/cardSwiper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        centerTitle: false,
        title: Text('Movies showing'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(
        child : Column(
          children: <Widget>[
            _swiperCards()
          ],
        )
      )
    );
  }
}

Widget _swiperCards(){
  return CardSwiper(
    elements: [1,2,3,4,5],
  );
}