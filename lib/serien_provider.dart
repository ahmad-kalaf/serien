import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:serien/serie.dart';

class SerienProvider extends ChangeNotifier{
  final Box _box;
  List<Serie> _serienliste = [];

  SerienProvider(this._box){
    _ladeDaten();
  }

  List<Serie> get serienliste => _serienliste;

  void _ladeDaten(){
    _serienliste = (_box.get('serienliste') as List).cast<Serie>() ?? [];
    notifyListeners();
  }

  void serieHinzufuegen(Serie serie){
    _serienliste.add(serie);
    _box.put('serienliste', _serienliste);
    notifyListeners();
  }

  void serieLoeschen(Serie s){
    if(_serienliste.contains(s)){
      _serienliste.remove(s);
      notifyListeners();
    }
  }
}