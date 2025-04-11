import 'dart:io';

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
  final _seasonCountTextController = TextEditingController();
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
                int.parse(_seasonCountTextController.text),
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
      body: Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: Platform.isAndroid || Platform.isIOS ? MediaQuery.of(context).size.aspectRatio : (9 / 16),
          child: SingleChildScrollView(
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
                    validator: fieldValidator(),
                  ),
                  TextFormField(
                    controller: _seasonCountTextController,
                    keyboardType: TextInputType.number,
                    decoration: deco(prefixIcon: Icon(Icons.onetwothree_rounded), labelText: "Number of Seasons"),
                    validator: fieldValidator(),
                  ),
                  TextFormField(
                    controller: _reviewTextController,
                    keyboardType: TextInputType.datetime,
                    decoration: deco(prefixIcon: Icon(Icons.reviews_rounded), labelText: "Rating (1 to 10)"),
                    validator: fieldValidator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? Function(String?)? fieldValidator() => (value) {
    if (value == null || value.isEmpty) {
      return "Please fill out";
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
