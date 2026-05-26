import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class DesignerScreen extends StatefulWidget {
  @override
  _DesignerScreenState createState() => _DesignerScreenState();
}

class _DesignerScreenState extends State<DesignerScreen> {
  final Flutter3DController controller = Flutter3DController();
  String stoleColor = "Bordeaux";

  final colors = ["Bordeaux","Noir","Vert","Bleu","Or"];

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
              child: Flutter3DViewer(
                controller: controller,
                src: 'assets/models/robe.glb',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Votre nom pour la broderie", style: TextStyle(fontSize:16,fontWeight:FontWeight.w600)),
                  SizedBox(height:8),
                  TextField(decoration: InputDecoration(hintText:"Ex: Amina B.", filled:true, fillColor:Colors.white, border:OutlineInputBorder(borderRadius:BorderRadius.circular(14), borderSide:BorderSide.none))),
                  SizedBox(height:20),
                  Text("Couleur de l'étole", style: TextStyle(fontSize:16,fontWeight:FontWeight.w600)),
                  SizedBox(height:10),
                  Wrap(spacing:10, children: colors.map((c)=> ChoiceChip(label:Text(c), selected: stoleColor==c, onSelected:(_)=> setState(()=> stoleColor=c))).toList()),
                  Spacer(),
                  SizedBox(width:double.infinity, height:54, child: ElevatedButton.icon(onPressed:(){}, icon:Icon(Icons.check), label:Text("Enregistrer le design"), style:ElevatedButton.styleFrom(backgroundColor:Colors.deepPurple, foregroundColor:Colors.white, shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(16))))),
                  SizedBox(height:20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
