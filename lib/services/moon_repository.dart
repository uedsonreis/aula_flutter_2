import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class MoonRepository {

  final LocalStorage _storage = LocalStorage('moons_json');

  Future<List<String>> get(String planetId) async {
    bool isRead = await _storage.ready;
    if (isRead) {
      dynamic json = _storage.getItem(planetId);
      if (json != null) {
        List<dynamic> list = jsonDecode(json);
        return list.map((e) => e.toString()).toList();
      }
    }
    return <String>[];
  }

  Future<void> add(String planetId, String moonName) async {
    List<String> moons = await get(planetId);
    moons.add(moonName);
    await _storage.setItem(planetId, jsonEncode(moons));
  }

  Future<void> remove(String planetId, String moonName) async {
    List<String> moons = await get(planetId);
    moons.removeWhere((element) => element == moonName);
    await _storage.setItem(planetId, jsonEncode(moons));
  }

}

final MoonRepository moonRepository = MoonRepository();