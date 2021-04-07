import 'package:flutter/material.dart';
import 'package:movie_app/src/models/character.dart';
import 'package:movie_app/src/models/movie.model.dart';
import 'package:movie_app/src/providers/character.provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar( movie ),
          SliverList(delegate: 
            SliverChildListDelegate(
              [ SizedBox( height : 10.0),
                _posterTitle( movie , context ),
                _description( movie ),
                _casting(context, movie)]
            )
          )
        ],  
      )
    );
  }

  Widget _createAppBar( Movie movie ){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title
        ),
        background: FadeInImage(
          image: NetworkImage( movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle( Movie movie, BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal : 20.0),
      child: Row(
        children : <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage( movie.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width : 20.0),
          Flexible(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.bodyText1,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.bodyText2 ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.bodyText1,)
                  ],
                )
            ],)
          )
        ]
      ),
    );
  }

  Widget _description(Movie movie){
    return Container(
      padding: EdgeInsets.symmetric(horizontal : 10.0 , vertical : 20.0),
      child: Text(
        movie.overview,
      ),
    );
  }

  Widget _casting(BuildContext context , Movie movie){
    final characterProvider = new CharacterProvider();
    return FutureBuilder(
      future: characterProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData)
          return _characterPageView( snapshot.data );
        else
          return Center(child: CircularProgressIndicator());
      }
    );
  }
  
  Widget _characterPageView( List<Character> characters ){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller : PageController(
          viewportFraction : 0.3,
          initialPage : 1
        ),
        itemCount: characters.length,
        itemBuilder: (context, i){
          return _characterCard(characters[i]);
        },
      )
    );
  }

  Widget _characterCard( Character character){
    return Container(
      child: Column(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(character.getCharacterPhoto()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          character.name,
          overflow: TextOverflow.ellipsis,
        )
      ],),
    );
  }

}
