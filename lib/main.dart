import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:serien/hive_registrar.g.dart';
import 'package:serien/serien_home_page.dart';
import 'package:serien/serien_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  var box = await Hive.openBox('serienbox');
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (context) => SerienProvider(box))], child: const Serien()),
  );
}

class Serien extends StatelessWidget {
  const Serien({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SerienHomePage(), debugShowCheckedModeBanner: false);
  }
}
