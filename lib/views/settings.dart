import 'package:flutter/material.dart';

import 'package:driver_bits/config.dart';
import 'package:driver_bits/tools/tagController.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'indoor';
  String _newId = '';
  String _newName = '';

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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (String? newValue) {
                  _newId = newValue!;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Id not';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Tag id'
                ),
              ),
              TextFormField(
                onSaved: (String? newValue) {
                  _newName = newValue!;
                },
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Name not set';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    labelText: 'Tag name'
                ),
              ),
              DropdownButtonFormField<String>(
                value: 'indoor',
                decoration: const InputDecoration(
                    labelText: 'Tag type'
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                items: <String>['indoor', 'outdoor', 'storage', 'sauna', 'fridge', 'freezer']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(child: Text(value), value: value);
                    })
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  print(_newId + ', ' +  _newName + ', ' + _selectedType);
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saving new tag'),),);
                    _formKey.currentState!.reset();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New tag saved'),),);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check fields'),),);
                  }
                },
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