import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:driver_bits/views/ui.dart';

var _textSizes = [28.0, 24.0, 18.0];

class Splash extends StatefulWidget {
  const Splash({Key? key}): super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(milliseconds: 6250), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MyHomePage(title: 'DriverBits')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Shimmer(
                period: const Duration(milliseconds: 2000),
                direction: ShimmerDirection.ltr,
                loop: 0,
                gradient: const RadialGradient(
                    stops: [0.0,0.75],
                    colors: [Colors.white, Colors.black87]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/driverbits.png',
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'DriverBits',
                  style: TextStyle(
                      fontSize: _textSizes[0] * 1.5,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}