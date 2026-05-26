import 'package:flutter/material.dart';

void main() => runApp(const TogaApp());

class TogaApp extends StatelessWidget {
  const TogaApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget { const Home({super.key}); @override State<Home> createState()=>_HomeState(); }

class _HomeState extends State<Home> {
  String couleur = 'Bordeaux';
  final couleurs = ['Bordeaux','Noir','Vert','Bleu','Or'];
  final nom = TextEditingController();

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FB),
      appBar: AppBar(title: const Text('Toga DZ - Concepteur'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Container(height: 280, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
          child: const Center(child: Icon(Icons.school, size: 120, color: Colors.deepPurple))),
        const SizedBox(height: 24),
        const Text('Votre nom pour la broderie', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(controller: nom, decoration: InputDecoration(hintText: 'Ex: Amina B.', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
        const SizedBox(height: 24),
        const Text("Couleur de l'étole", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, children: couleurs.map((c)=>ChoiceChip(label: Text(c), selected: couleur==c, onSelected: (_)=>setState(()=>couleur=c))).toList()),
        const SizedBox(height: 30),
        SizedBox(height: 54, child: ElevatedButton.icon(
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Design enregistré: ${nom.text} - $couleur')));
          },
          icon: const Icon(Icons.check),
          label: const Text('Enregistrer le design'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        )),
      ]),
    );
  }
}
