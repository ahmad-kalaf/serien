import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:serien/hive_registrar.g.dart';
import 'package:serien/series_home_page.dart';
import 'package:serien/series_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  var box = await Hive.openBox('seriesBox');
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (context) => SeriesProvider(box))], child: const Series()),
  );
}

class Series extends StatelessWidget {
  const Series({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SeriesHomePage(), debugShowCheckedModeBanner: false);
  }
}
