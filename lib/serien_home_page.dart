import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serien/constants.dart';
import 'package:serien/hinzufuegen.dart';
import 'package:serien/serie.dart';
import 'package:serien/serien_provider.dart';

class SerienHomePage extends StatefulWidget {
  const SerienHomePage({super.key});

  @override
  State<SerienHomePage> createState() => _SerienHomePageState();
}

class _SerienHomePageState extends State<SerienHomePage> {
  List<Serie> ausgewaehlteSerien = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SerienProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SERIEN'),
        foregroundColor: kForeGroundColor,
        backgroundColor: kBackGroundColor,
        actions: [
          TextButton.icon(
            onPressed:
                ausgewaehlteSerien.isEmpty
                    ? null
                    : () {
                      for (Serie element in List.of(ausgewaehlteSerien)) {
                        provider.serieLoeschen(element) ? ausgewaehlteSerien.remove(element) : ();
                      }
                    },
            icon: Icon(Icons.delete_forever, color: ausgewaehlteSerien.isEmpty ? null : kForeGroundColor),
            label: Text(ausgewaehlteSerien.length.toString()),
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(kForeGroundColor),
              // backgroundColor: WidgetStatePropertyAll(kBackGroundColor)
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.serienliste.length,
        itemBuilder: (context, index) {
          Serie serie = provider.serienliste[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                !ausgewaehlteSerien.contains(serie) ? ausgewaehlteSerien.add(serie) : ausgewaehlteSerien.remove(serie);
              });
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Löschen?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Abbrechen'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.serieLoeschen(serie);
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(style: BorderStyle.solid)),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
                color:
                    ausgewaehlteSerien.contains(provider.serienliste[index])
                        ? kSelectedBackGroundColor
                        : kBackGroundColor,
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(serie.name, style: TextStyle(color: kForeGroundColor)),
                  Text('Erscheinungsjahr: ${serie.erscheinungsjahr.year}', style: TextStyle(color: kForeGroundColor)),
                  Text('Anzahl Staffeln: ${serie.anzahlStaffel}', style: TextStyle(color: kForeGroundColor)),
                  Text('Bewertung (0 bis 5 Sterne): ${serie.bewertung}', style: TextStyle(color: kForeGroundColor)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Hinzufuegen()));
          if (result != null) {
            provider.serieHinzufuegen(result);
          }
        },
        backgroundColor: kBackGroundColor,
        foregroundColor: kForeGroundColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
