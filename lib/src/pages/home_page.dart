import 'package:flutter/material.dart';
import 'package:movie_app/src/components/cardSwiper.dart';
import 'package:movie_app/src/providers/movie.provider.dart';

class HomePage extends StatelessWidget {

  final movieProvider = MovieProvider();
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
          ],
        )
      )
    );
  }

  Widget _swiperCards(){
    return FutureBuilder(
      future : movieProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData)
        return CardSwiper( elements : snapshot.data );
        else
        return Container(child: Center(child: CircularProgressIndicator()));
      },
    );    
  }

  Widget _footer(context){
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subtitle1,),
          FutureBuilder(
            future : movieProvider.getPopularMovies(),
            builder : (BuildContext context, AsyncSnapshot<List> snapshot){
             snapshot.data.forEach((element) {
               print(element.title);
             });
             return Container();
            }

          )
        ],),
    );
  }
}