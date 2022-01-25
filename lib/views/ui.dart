import 'package:flutter/material.dart';

import 'package:driver_bits/views/settings.dart';
import 'package:driver_bits/views/taglist.dart';

import 'package:driver_bits/config.dart';

// timestamp:1629472635430
// driver:"screwdriver-testbed-20212021"
// rssi:-60
// temperature:28.71
// humidity:35.8
// pressure:100784
// battery:3034
// measurementSequenceNumber:28827
// tag:"ef9d0e26ed52"
// mode:"outdoor"
// viewtype:"gauge"

class MyHomePage extends StatefulWidget {
  final String _title;
  const MyHomePage({Key? key, required String title}) : _title = title, super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  @override
  initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  void _selectView(int indexOf) {
    setState(() {
      _index = indexOf;
    });
  }

  static final List<Widget> _views = <Widget>[
    const TagList(),
    const Settings(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget._title
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: _views.elementAt(_index),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: currentTheme.isItDark
          ? Colors.amber
          : Colors.teal,
        currentIndex: _index,
        onTap: _selectView,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tags'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          )
        ]
      ),
    );
  }
}