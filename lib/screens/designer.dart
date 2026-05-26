import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DesignerScreen extends StatefulWidget {
  @override
  _DesignerScreenState createState() => _DesignerScreenState();
}

class _DesignerScreenState extends State<DesignerScreen> {
  String stoleColor = "#800020";
  String studentName = "";

  final colors = {
    "Bordeaux": "#800020",
    "Noir": "#000000",
    "Vert": "#006233",
    "Bleu": "#0A1931",
    "Or": "#C9A227",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F6FB),
      appBar: AppBar(
        title: Text('Toga DZ - Concepteur 3D', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
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
              child: ModelViewer(
                src: 'assets/models/robe.glb',
                alt: "Toge de graduation",
                autoRotate: true,
                cameraControls: true,
                ar: false,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Votre nom pour la broderie", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  TextField(
                    onChanged: (v) => setState(() => studentName = v),
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
                      bool selected = stoleColor == e.value;
                      return ChoiceChip(
                        label: Text(e.key),
                        selected: selected,
                        onSelected: (_) => setState(() => stoleColor = e.value),
                        selectedColor: Color(int.parse(e.value.replaceFirst('#', '0xFF'))),
                        labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                      );
                    }).toList(),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: saveDesign,
                      icon: Icon(Icons.check),
                      label: Text("Enregistrer le design", style: TextStyle(fontSize: 17)),
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

  void saveDesign() {
    final design = {"stole_color": stoleColor, "name": studentName};
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Design enregistré !")),
    );
  }
}
