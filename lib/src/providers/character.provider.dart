
import 'dart:async';
import 'dart:convert';
import 'package:movie_app/src/models/character.dart';
import 'package:http/http.dart' as http;

class CharacterProvider{
  String _apikey   = '1865f43a0549ca50d341dd9ab8b29f49';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  List<Character> characters = [];

  final _characterStreamController = StreamController<List<Character>>.broadcast();

  Function(List<Character>) get characterSink => _characterStreamController.sink.add;
  Stream<List<Character>> get characterStream => _characterStreamController.stream;

  void disposeStreams(){
    _characterStreamController?.close();
  }

  Future<List<Character>> getCast(String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key' : _apikey,
      'language' : _language
    });

    final response = await http.get(url);
    final decodedData = json.decode( response.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.characters;
  }

}