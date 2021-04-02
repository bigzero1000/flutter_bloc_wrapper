import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            Translations.of(context).text('home'),
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
