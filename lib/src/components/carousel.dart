import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie.model.dart';

class Carousel extends StatelessWidget {

  final List<Movie> movies;
  Carousel( { @required this.movies})
  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
    
    return Container(

    );
  }
}