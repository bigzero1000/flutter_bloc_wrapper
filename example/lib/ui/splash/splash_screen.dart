import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
            child: Text(
          Translations.of(context).text('splash_text'),
          style: const TextStyle(fontSize: 25, color: Colors.black),
        )),
      ),
    );
  }
}
