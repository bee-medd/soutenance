import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Toga3DViewerScreen(),
    );
  }
}

class Toga3DViewerScreen extends StatelessWidget {
  const Toga3DViewerScreen({super.key});
  @override Widget build(BuildContext context) {
    final controller = Flutter3DController();
    return Scaffold(
      appBar: AppBar(title: const Text('Toga DZ - Concepteur 3D'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Flutter3DViewer(
            controller: controller,
            src: 'assets/models/robe.glb',
          ),
        ),
        const Padding(padding: EdgeInsets.all(20), child: Text("Votre nom pour la broderie")),
        Padding(padding: const EdgeInsets.symmetric(horizontal:20), child: TextField(decoration: InputDecoration(hintText:"Ex: Amina B.", filled:true, fillColor:Colors.white))),
      ]),
    );
  }
}
