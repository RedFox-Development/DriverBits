import 'dart:io';
import 'package:driver_bits/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:driver_bits/views/splash.dart';
import 'package:driver_bits/utility_classes/tag.dart';
import 'package:driver_bits/tools/tagController.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  hive = await Hive.openBox('driverbit.general');
  tagBox = await Hive.openBox('driverbit.tags');
  tagBox.put('default', []);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const Main()));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _Main();
}

class _Main extends State<Main> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  final ThemeData _dark = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        background: Colors.black54,
        error: Colors.red,
        onBackground: Colors.amberAccent,
        onError: Colors.black38,
        onPrimary: Colors.black45,
        onSecondary: Colors.black38,
        onSurface: Colors.amberAccent,
        primary: Colors.teal,
        primaryVariant: Colors.tealAccent,
        secondary: Colors.amber,
        secondaryVariant: Colors.amberAccent,
        surface: Colors.black38
    ),
  );

  final ThemeData _light = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        background: Colors.white70,
        error: Colors.red,
        onBackground: Colors.amber,
        onError: Colors.black38,
        onPrimary: Colors.teal,
        onSecondary: Colors.amber,
        onSurface: Colors.teal,
        primary: Colors.amber,
        primaryVariant: Colors.amberAccent,
        secondary: Colors.teal,
        secondaryVariant: Colors.tealAccent,
        surface: Colors.white54
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _light,
      darkTheme: _dark,
      themeMode: currentTheme.currentTheme(),
      debugShowMaterialGrid: false,
      home: const Splash(),
    );
  }
}

// MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: _darkOrNot() ? _dark : _light,
//       debugShowMaterialGrid: false,
//       home: const Splash(dark: true),
//     )