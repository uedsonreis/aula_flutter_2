import 'dart:convert';

import 'package:aula_flutter_2/models/planet.dart';
import 'package:http/http.dart' as http;

class PlanetService {

  final String _url = 'https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list';

  Future<List<Planet>> getPlanets() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: <String, String> {
        'Content-Type': 'applcation/json; charset=UTF-8',
        'X-RapidAPI-Key': '5e63c3b71amsh23322dff397b496p139575jsnbb1f7014177e',
        'X-RapidAPI-Host': 'planets-info-by-newbapi.p.rapidapi.com'
      }
    );

    List<dynamic> list = List.from(jsonDecode(response.body));
    List<Planet> planets = list.map((planet) => Planet.fromJson(planet)).toList();
    planets.sort((a, b) { return a.id.compareTo(b.id); });
    return planets;
  }

}