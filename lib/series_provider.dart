import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:serien/series.dart';

class SeriesProvider extends ChangeNotifier {
  final Box _box;
  List<Series> _seriesList = [];

  SeriesProvider(this._box) {
    _loadData();
  }

  List<Series> get seriesList => _seriesList;

  void _loadData() {
    final data = _box.get('seriesList');
    if (data is List) {
      _seriesList = data.cast<Series>();
    } else {
      _seriesList = [];
    }
    notifyListeners();
  }

  void addSeries(Series series) {
    _seriesList.add(series);
    _box.put('seriesList', _seriesList);
    notifyListeners();
  }

  bool deleteSeries(Series s) {
    if (_seriesList.contains(s)) {
      _seriesList.remove(s);
      _box.put('seriesList', _seriesList);
      notifyListeners();
      return true;
    }
    return false;
  }
}
