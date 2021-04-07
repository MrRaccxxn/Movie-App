import 'package:flutter/material.dart';
import 'package:movie_app/src/models/movie.model.dart';

class Carousel extends StatelessWidget {

  final List<Movie> movies;
  final Function nextPage;
  Carousel( { @required this.movies , @required this.nextPage});
  final _pageController = new PageController(
    initialPage : 1,
    viewportFraction : 0.3
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 400){
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller:  _pageController,
        itemCount: movies.length,
        itemBuilder: (context, i){
          return _card(context, movies[i]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie){
    movie.uniqueId = '${movie.id}-card';
    final card = Container(
        margin: EdgeInsets.only(right : 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ]
        ),
      );

      return GestureDetector(
        child: card,
        onTap: () {
          Navigator.pushNamed(context, 'movie-detail', arguments: movie);
        },
      );
  }
}