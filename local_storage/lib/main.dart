import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new MyHomePage(),
      routes: {NextPage.routeName: (context) => NextPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _textController,
            ),
          ),
          new ListTile(
            title: new RaisedButton(
              child: new Text("Next"),
              onPressed: () {
                saveName();
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new NextPage(value: _textController.text),
                );
                Navigator.of(context).push(route);
              },
            ),
          ),
        ],
      ),
    );
  }

  void saveName() {
    String name = _textController.text;
    saveNamePrefrence(name).then((bool committed) {
      Navigator.of(context).pushNamed(NextPage.routeName);
    });
  }
}

Future<bool> saveNamePrefrence(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  return prefs.commit();
}

Future<String> getNamePreference() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}

class NextPage extends StatefulWidget {
  final String value;
  static String routeName = '/nextPage';
  NextPage({Key key, this.value}) : super(key: key);

  @override
  _NextPageState createState() => new _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String _name = "";

  @override
  void initState() {
    getNamePreference().then((name) {
        setState(() {
          _name = name;
        });
    } );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Next Page")),
        body: new Text(_name));
  }
}
