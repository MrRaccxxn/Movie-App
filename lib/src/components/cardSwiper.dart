import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_app/src/models/movie.model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Movie> elements;

  CardSwiper({ @required this.elements });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return  Container(
      padding: EdgeInsets.only(top : 10.0),
      child: new Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( elements[index].getPosterImg()),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover,
            )
          );
        },
        itemCount: elements.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}