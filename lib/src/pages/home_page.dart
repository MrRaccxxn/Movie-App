import 'package:flutter/material.dart';

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
      body: SafeArea(child:      
        Text('Bienvenido a movie App'),
      ) 
    );
  }
}