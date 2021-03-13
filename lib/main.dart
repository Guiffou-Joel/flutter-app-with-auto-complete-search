import "package:flutter/material.dart";
import 'package:auto_complete_search/auto_complete_search.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final List areaList = [
    {"name": "Block 1", "id": "124612615"},
    {"name": "Block 2", "id": "124612615"},
    {"name": "Block 3", "id": "124612615"},
    {"name": "PECHS block 1", "id": "124612615"},
    {"name": "PECHS block 2", "id": "124612615"},
    {"name": "PECHS block 3", "id": "124612615"},
    {"name": "PECHS block 4", "id": "124612615"},
    {"name": "PECHS block 5", "id": "124612615"},
    {"name": "PECHS block 6", "id": "124612615"},
    {"name": "PECHS block 7", "id": "12461265"},
    {"name": "PECHS block 8", "id": "12461215"},
    {"name": "PECHS block 9", "id": "12461615"},
    {"name": "PECHS block 0", "id": "12462615"},
    {"name": "PECHS block 89", "id": "12612615"},
    {"name": "PECHS block 88", "id": "1261265"},
    {"name": "PECHS block 87", "id": "14612615"},
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App with Auto Complete Search',
      home: Home(title: 'Auto Complete Search Demo', areaList: areaList),
    );
  }
}

class Area {
  final String name;
  final String id;
  static List<Area> areas;

  Area({this.name, this.id});
}

class Home extends StatefulWidget {
  final String title;
  final List areaList;
  Home({Key key, this.title, this.areaList}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController areaCtrl = TextEditingController();
  GlobalKey key = new GlobalKey<AutoCompleteSearchFieldState<Area>>();
  List<Area> areas = [];

  @override
  void initState() {
    List<Area> areas = widget.areaList
        .map((area) => Area(name: area["name"], id: area["id"]))
        .toList();
    Area.areas = areas;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: AutoCompleteSearchField(
            key: key,
            controller: areaCtrl,
            submitOnSuggestionTap: true,
            itemSorter: (Area a, Area b) =>
                a.name.toLowerCase().compareTo(b.name.toLowerCase()),
            suggestions: Area.areas,
            itemSubmitted: (Area area) {
              setState(() {
                this.areaCtrl.text = area.name;
              });
            },
            suggestionsDirection: SuggestionsDirection.down,
            suggestionWidgetSize: 50.0,
            itemBuilder: (context, suggestion) => new Padding(
                child: new ListTile(
                  title: new Text(suggestion.name),
                ),
                padding: const EdgeInsets.all(4.0)),
            itemFilter: (suggestion, input) =>
                suggestion.name.toLowerCase().contains(input.toLowerCase()),
            clearOnSubmit: false,
          ),
        ),
      ),
    );
  }
}
