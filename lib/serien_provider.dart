import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:serien/serie.dart';

class SerienProvider extends ChangeNotifier {
  final Box _box;
  List<Serie> _serienliste = [];

  SerienProvider(this._box) {
    _ladeDaten();
  }

  List<Serie> get serienliste => _serienliste;

  void _ladeDaten() {
    final daten = _box.get('serienliste');
    if (daten is List) {
      _serienliste = daten.cast<Serie>();
    } else {
      _serienliste = [];
    }
    notifyListeners();
  }

  void serieHinzufuegen(Serie serie) {
    _serienliste.add(serie);
    _box.put('serienliste', _serienliste);
    notifyListeners();
  }

  bool serieLoeschen(Serie s) {
    if (_serienliste.contains(s)) {
      _serienliste.remove(s);
      _box.put('serienliste', _serienliste);
      notifyListeners();
      return true;
    }
    return false;
  }
}
