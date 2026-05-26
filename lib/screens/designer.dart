import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class DesignerScreen extends StatefulWidget {
  @override
  _DesignerScreenState createState() => _DesignerScreenState();
}

class _DesignerScreenState extends State<DesignerScreen> {
  late Object robe;
  String stoleColor = "#800020";
  String studentName = "";

  final colors = {
    "Bordeaux": 0xFF800020,
    "Noir": 0xFF000000,
    "Vert": 0xFF006233,
    "Bleu": 0xFF0A1931,
    "Or": 0xFFC9A227,
  };

  void _onSceneCreated(Scene scene) {
    robe = Object(fileName: "assets/models/robe.glb");
    robe.rotation.setValues(0, 30, 0);
    robe.scale.setValues(2.5, 2.5, 2.5);
    scene.world.add(robe);
    scene.camera.zoom = 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6FB),
      appBar: AppBar(
        title: Text('Toga DZ - Concepteur 3D'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.48,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Cube(
                onSceneCreated: _onSceneCreated,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Votre nom pour la broderie", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  TextField(
                    onChanged: (v) => studentName = v,
                    decoration: InputDecoration(
                      hintText: "Ex: Amina B.",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Couleur de l'étole", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: colors.entries.map((e) {
                      bool selected = stoleColor == "#${e.value.toRadixString(16).substring(2).toUpperCase()}";
                      return ChoiceChip(
                        label: Text(e.key),
                        selected: selected,
                        onSelected: (_) => setState(() => stoleColor = "#${e.value.toRadixString(16).substring(2).toUpperCase()}"),
                        selectedColor: Color(e.value),
                        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Design enregistré !"))),
                      icon: Icon(Icons.check),
                      label: Text("Enregistrer le design"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
