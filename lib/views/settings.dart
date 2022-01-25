import 'package:flutter/material.dart';

import 'package:driver_bits/config.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: ListView(
          children: <Widget>[
            SwitchListTile(
              activeColor: Colors.tealAccent,
              activeTrackColor: Colors.teal,
              inactiveTrackColor: Colors.amber,
              inactiveThumbColor: Colors.amberAccent,
              title: currentTheme.isItDark
                  ? const Text('Switch to light theme')
                  : const Text('Switch to dark theme'),
              value: currentTheme.isItDark,
              onChanged: currentTheme.switchTheme,
              secondary: currentTheme.isItDark
                  ? const Icon(Icons.light_mode, color: Colors.amber)
                  : const Icon(Icons.dark_mode, color: Colors.teal,),
            )
          ],
        ),
      ),
    );
  }
}