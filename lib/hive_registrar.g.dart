// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:serien/series.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(SeriesAdapter());
  }
}
