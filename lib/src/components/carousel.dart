import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie.model.dart';

class Carousel extends StatelessWidget {

  final List<Movie> movies;
  Carousel( { @required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage : 1,
          viewportFraction : 0.3
        ),
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context){
    return  movies.map((movie) {
      print(movie);
      return Container(
        margin: EdgeInsets.only(right : 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ]
        ),
      );
    }).toList();
  }
}