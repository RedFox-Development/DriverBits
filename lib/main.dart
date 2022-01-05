import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:driver_bits/blocs/provider.dart';
import 'package:driver_bits/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
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
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              background: Color(0xff292727),
              error: Color(0xffb00020),
              onBackground: Color(0xffEBC43C),
              onError: Colors.black38,
              onPrimary: Colors.black45,
              onSecondary: Colors.black38,
              onSurface: Color(0xffEBC43C),
              primary: Color(0xff437563),
              primaryVariant: Color(0xff4a826e),
              secondary: Color(0xffEBC43C),
              secondaryVariant: Color(0xffEFD063),
              surface: Color(0xff292727)
            )
        ),
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: const Splash(),
      ),
    );
  }
}
