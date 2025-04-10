import 'package:flutter/material.dart';
import 'package:serien/serie.dart';

class Hinzufuegen extends StatefulWidget {
  const Hinzufuegen({super.key});

  @override
  State<Hinzufuegen> createState() => _HinzufuegenState();
}

class _HinzufuegenState extends State<Hinzufuegen> {
  final _formKey = GlobalKey<FormState>();
  final _titleTxtController = TextEditingController();
  final _seasonCountTxtController = TextEditingController();
  final _reviewTxtController = TextEditingController();
  final _releaseDateTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color?>(Colors.green),
            foregroundColor: WidgetStatePropertyAll<Color?>(Colors.white),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Serie serie = Serie(
                _titleTxtController.text,
                int.parse(_seasonCountTxtController.text),
                int.parse(_reviewTxtController.text),
                DateTime(int.parse(_releaseDateTxtController.text)),
              );
              Navigator.pop(context, serie); // Rückgabe an den Aufrufer
            }
          },
          child: Text("Speichern"),
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                controller: _titleTxtController,
                decoration: deco(prefixIcon: Icon(Icons.title_rounded), labelText: "Titel"),
                validator: fieldValidator(),
              ),
              TextFormField(
                controller: _releaseDateTxtController,
                keyboardType: TextInputType.datetime,
                decoration: deco(prefixIcon: Icon(Icons.date_range_rounded), labelText: "Erscheinungsjahr"),
                validator: fieldValidator(),
              ),
              TextFormField(
                controller: _seasonCountTxtController,
                keyboardType: TextInputType.number,
                decoration: deco(prefixIcon: Icon(Icons.onetwothree_rounded), labelText: "Anzahl Staffeln"),
                validator: fieldValidator(),
              ),
              TextFormField(
                controller: _reviewTxtController,
                keyboardType: TextInputType.datetime,
                decoration: deco(prefixIcon: Icon(Icons.reviews_rounded), labelText: "Bewertung (1 bis 10)"),
                validator: fieldValidator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? Function(String?)? fieldValidator() => (value) {
    if (value == null || value.isEmpty) {
      return "Bitte ausfüllen";
    }
    return null;
  };

  InputDecoration deco({Widget? prefixIcon, String? labelText}) => InputDecoration(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)),
    border: OutlineInputBorder(borderSide: BorderSide()),
    fillColor: Colors.white,
    filled: true,
    prefixIcon: prefixIcon,
    labelText: labelText,
  );
}
