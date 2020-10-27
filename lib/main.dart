import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;

  @override 
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState.showBottomSheet((context) {
        return new Container(
          height: 300.0,
          color: Colors.amber,
          child: new Center(
            child: new Text("Ola Amigos"),
          ),
        );
    })
      .closed
      .whenComplete(() {
        if(mounted) {
          setState(() {
            _showPersBottomSheetCallBack = _showBottomSheet;
          });
        }
      });
  }

  void _showModalSheet() {
    showModalBottomSheet(context: context, 
    builder: (builder){
        return new Container(
          height: 300.0,
          color: Colors.white,
          child: new Center(
            child: new Text("Ola Amigos"),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Flutter bottom sheet"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: _showPersBottomSheetCallBack,
                child: new Text("Persistent"),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 10.0)
                ),
                new RaisedButton(
                  onPressed: _showModalSheet,
                  child: new Text("Modal"),)
            ],
          ) ,
          ),
      ),
    );
  }
}