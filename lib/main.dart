import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:driver_bits/blocs/provider.dart';

import 'package:driver_bits/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(const Main()));
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: const ColorScheme(
              error: Colors.red,
              surface: Colors.black26,
              background: Colors.black45,
              primary: Color(0xff2faeef),
              primaryVariant: Colors.orange,
              secondary: Color(0xff3466b0),
              secondaryVariant: Colors.lightGreenAccent,
              onPrimary: Colors.black45,
              onSecondary: Colors.black45,
              onError: Colors.redAccent,
              onBackground: Colors.lightGreenAccent,
              onSurface: Color(0xff3466b0),
              brightness: Brightness.dark
            )
        ),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: const Splash(),
      ),
    );
  }
}
