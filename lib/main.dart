import 'package:flutter/material.dart';
import 'screens/designer.dart';

void main() => runApp(TogaApp());

class TogaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toga DZ',
      theme: ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Cairo'),
      home: DesignerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
