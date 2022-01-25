import 'package:flutter/material.dart';

import 'package:driver_bits/blocs/applicationBloc.dart';

class Provider extends InheritedWidget {
  final appBloc = AppBloc();

  Provider({Key? key, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(oldWidget) => true;

  static AppBloc of(context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).appBloc;
  }
}