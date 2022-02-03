import 'package:flutter/material.dart';

import 'package:driver_bits/config.dart';
import 'package:driver_bits/tools/tagController.dart';

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

    Widget _themeSwitcher() {
      return SwitchListTile(
        activeColor: Colors.teal,
        activeTrackColor: Colors.amberAccent,
        inactiveTrackColor: Colors.teal,
        inactiveThumbColor: Colors.amber,
        title: currentTheme.isItDark
            ? const Text('Switch to light theme')
            : const Text('Switch to dark theme'),
        value: currentTheme.isItDark,
        onChanged: currentTheme.switchTheme,
        secondary: currentTheme.isItDark
            ? const Icon(Icons.light_mode, color: Colors.amber)
            : const Icon(Icons.dark_mode, color: Colors.teal,),
      );
    }

    Widget _tagAdder() {
      String _selectedType = 'indoor';
      String _newId = '';
      String _newName = '';

      void _handleTagAdder() {
        setState(() {
          _newId = '';
          _newName = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saving new tag')),);
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (String newValue) {
                  setState(() {
                    _newId = newValue;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Set tag id'
                ),
              ),
              TextFormField(
                onChanged: (String newValue) {
                  setState(() {
                    _newName = newValue;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Set tag name'
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (String? newValue) => setState(() {
                  _selectedType = newValue!;
                }),
                items: <String>['indoor', 'outdoor', 'storage', 'sauna', 'fridge', 'freezer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(child: Text(value), value: value);
                })
                    .toList(),
              ),
              OutlinedButton(
                onPressed: _handleTagAdder,
                child: const Text('Save tag'),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: ListView(
          children: <Widget>[
            _themeSwitcher(),
            _tagAdder(),
          ],
        ),
      ),
    );
  }
}