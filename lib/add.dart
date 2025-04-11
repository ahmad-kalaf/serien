import 'package:flutter/material.dart';
import 'package:serien/series.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  final _titleTextController = TextEditingController();
  final _seasonsCountTextController = TextEditingController();
  final _reviewTextController = TextEditingController();
  final _releaseDateTextController = TextEditingController();

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
              Series series = Series(
                _titleTextController.text,
                int.parse(_seasonsCountTextController.text),
                int.parse(_reviewTextController.text),
                DateTime(int.parse(_releaseDateTextController.text)),
              );
              Navigator.pop(context, series); // Return to caller
            }
          },
          child: Text("Save"),
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
                controller: _titleTextController,
                decoration: deco(prefixIcon: Icon(Icons.title_rounded), labelText: "Title"),
                validator: fieldValidator(),
              ),
              TextFormField(
                controller: _releaseDateTextController,
                keyboardType: TextInputType.datetime,
                decoration: deco(prefixIcon: Icon(Icons.date_range_rounded), labelText: "Release Year"),
                validator: fieldValidator(additionalValidator: _checkReleaseDate),
              ),
              TextFormField(
                controller: _seasonsCountTextController,
                keyboardType: TextInputType.number,
                decoration: deco(prefixIcon: Icon(Icons.onetwothree_rounded), labelText: "Number of Seasons"),
                validator: fieldValidator(additionalValidator: _checkSeasonsCount),
              ),
              TextFormField(
                controller: _reviewTextController,
                keyboardType: TextInputType.datetime,
                decoration: deco(prefixIcon: Icon(Icons.reviews_rounded), labelText: "Rating (1 to 10)"),
                validator: fieldValidator(additionalValidator: _checkReview),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? Function(String?)? fieldValidator({String? Function()? additionalValidator}) => (value) {
    if (value == null || value.isEmpty) {
      return "Bitte ausfüllen";
    }
    if (additionalValidator != null) {
      // returns null or "Ungültige Eingabe"
      return additionalValidator();
    }
    return null;
  };

  String? _checkReleaseDate() {
    try {
      int year = int.parse(_releaseDateTextController.text);
      if (year < 1500 || year > (DateTime.now().year + 200)) {
        return "Ungültige Eingabe";
      }
    } catch (e) {
      // handle error (e.g. empty _releaseDateTextController.text)
      return "Ungültige Eingabe";
    }
    return null;
  }

  String? _checkReview() {
    try {
      int review = int.parse(_reviewTextController.text);
      if (review < 1 || review > 10) {
        return "Ungültige Eingabe";
      }
    } catch (e) {
      // handle error (e.g. empty _releaseDateTextController.text)
      return "Ungültige Eingabe";
    }
    return null;
  }

  String? _checkSeasonsCount() {
    try {
      int seasonsCount = int.parse(_seasonsCountTextController.text);
      if (seasonsCount < 1) {
        return "Ungültige Eingabe";
      }
    } catch (e) {
      // handle error (e.g. empty _releaseDateTextController.text)
      return "Ungültige Eingabe";
    }
    return null;
  }

  InputDecoration deco({Widget? prefixIcon, String? labelText}) => InputDecoration(
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)),
    border: OutlineInputBorder(borderSide: BorderSide()),
    fillColor: Colors.white,
    filled: true,
    prefixIcon: prefixIcon,
    labelText: labelText,
  );
}
