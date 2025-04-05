import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serien/constants.dart';
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
                      for (Serie element in ausgewaehlteSerien) {
                        provider.serieLoeschen(element);
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
          return GestureDetector(
            onTap: () {
              setState(() {
                !ausgewaehlteSerien.contains(provider.serienliste[index])
                    ? ausgewaehlteSerien.add(provider.serienliste[index])
                    : ausgewaehlteSerien.remove(provider.serienliste[index]);
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
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.serieLoeschen(provider.serienliste[index]);
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
              child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(color: kForeGroundColor),
                provider.serienliste[index].toString(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Controller für die Eingabefelder
          TextEditingController nameController = TextEditingController();
          TextEditingController staffelnController = TextEditingController();
          TextEditingController bewertungController = TextEditingController();
          TextEditingController jahrController = TextEditingController();

          // Dialog anzeigen
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Neue Serie hinzufügen'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name der Serie')),
                      TextField(
                        controller: staffelnController,
                        decoration: InputDecoration(labelText: 'Anzahl Staffeln'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: bewertungController,
                        decoration: InputDecoration(labelText: 'Bewertung (0–5)'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: jahrController,
                        decoration: InputDecoration(labelText: 'Erscheinungsjahr'),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Abbrechen'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text.trim();
                      int staffeln = int.tryParse(staffelnController.text) ?? -1;
                      int bewertung = int.tryParse(bewertungController.text) ?? -1;
                      int jahr = int.tryParse(jahrController.text) ?? -1;

                      // Gültigkeit prüfen
                      if (name.isNotEmpty &&
                          staffeln >= 0 &&
                          bewertung >= 0 &&
                          bewertung <= 5 &&
                          jahr >= 1 &&
                          jahr <= DateTime.now().year + 100) {
                        Serie neueSerie = Serie(name, staffeln, bewertung, DateTime(jahr));

                        provider.serieHinzufuegen(neueSerie);
                        Navigator.of(context).pop();
                      } else {
                        // Optional: Feedback, wenn Eingaben ungültig sind
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Bitte gültige Werte eingeben.')));
                      }
                    },
                    child: Text('Hinzufügen'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: kBackGroundColor,
        foregroundColor: kForeGroundColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
