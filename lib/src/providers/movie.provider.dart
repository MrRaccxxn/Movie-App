import 'dart:async';
import 'dart:convert';
import 'package:movie_app/src/models/movie.model.dart';
import 'package:http/http.dart' as http;

class MovieProvider{
  String _apikey   = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularPage = 0;
  bool _isSearching = false;
  List<Movie> _popular = [];
  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Movie>> getNowPlaying() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });
    
    return await _getData(url);
  }

  Future<List<Movie>> getPopularMovies() async{
    if(_isSearching) return [];
    _isSearching = true;
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language' : _language,
      'page' : _popularPage.toString()
    });

    final response = await _getData(url);
    _popular.addAll(response);
    popularSink(_popular);
    _isSearching = false;
    return response;
  }

  Future<List<Movie>> _getData(Uri url) async{
    final response = await http.get( url );
    final decodedData = json.decode( response.body );
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }
}