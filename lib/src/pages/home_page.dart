import 'package:flutter/material.dart';
import 'package:movie_app/src/components/cardSwiper.dart';
import 'package:movie_app/src/providers/movie.provider.dart';

import '../components/carousel.dart';

class HomePage extends StatelessWidget {

  final movieProvider = MovieProvider();
  @override

  Widget build(BuildContext context) {

    movieProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar( 
        centerTitle: false,
        title: Text('Welcome to Cinema'),
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
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1,)
          ),
          StreamBuilder(
            stream: movieProvider.popularStream,
            builder : (BuildContext context, AsyncSnapshot<List> snapshot){
              if(snapshot.hasData){
                 return Carousel(
                   movies: snapshot.data,
                   nextPage: movieProvider.getPopularMovies,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }

          )
        ],),
    );
  }
}