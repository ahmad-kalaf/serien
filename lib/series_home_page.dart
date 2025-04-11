import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serien/constants.dart';
import 'package:serien/add.dart';
import 'package:serien/series.dart';
import 'package:serien/series_provider.dart';

class SeriesHomePage extends StatefulWidget {
  const SeriesHomePage({super.key});

  @override
  State<SeriesHomePage> createState() => _SeriesHomePageState();
}

class _SeriesHomePageState extends State<SeriesHomePage> {
  List<Series> selectedSeries = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SeriesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('SERIES'),
        foregroundColor: kForegroundColor,
        backgroundColor: kBackgroundColor,
        actions: [
          TextButton.icon(
            onPressed:
                selectedSeries.isEmpty
                    ? null
                    : () {
                      for (Series element in List.of(selectedSeries)) {
                        provider.deleteSeries(element) ? selectedSeries.remove(element) : ();
                      }
                    },
            icon: Icon(Icons.delete_forever, color: selectedSeries.isEmpty ? null : kForegroundColor),
            label: Text(selectedSeries.length.toString()),
            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(kForegroundColor)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.seriesList.length,
        itemBuilder: (context, index) {
          Series series = provider.seriesList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                !selectedSeries.contains(series) ? selectedSeries.add(series) : selectedSeries.remove(series);
              });
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete?'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          provider.deleteSeries(series);
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
                    selectedSeries.contains(provider.seriesList[index]) ? kSelectedBackgroundColor : kBackgroundColor,
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(series.name, style: TextStyle(color: kForegroundColor)),
                  Text('Release Year: ${series.releaseYear.year}', style: TextStyle(color: kForegroundColor)),
                  Text('Number of Seasons: ${series.numberOfSeasons}', style: TextStyle(color: kForegroundColor)),
                  Text('Rating (0 to 5 stars): ${series.rating}', style: TextStyle(color: kForegroundColor)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => Add()));
          if (result != null) {
            provider.addSeries(result);
          }
        },
        backgroundColor: kBackgroundColor,
        foregroundColor: kForegroundColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
