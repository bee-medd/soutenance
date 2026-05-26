import 'package:flutter/material.dart';
import 'screens/designer.dart';

void main() => runApp(TogaApp());

class TogaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toga DZ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
      home: DesignerScreen(),
    );
  }
}
