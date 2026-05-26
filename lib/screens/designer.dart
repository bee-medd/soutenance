import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DesignerScreen extends StatefulWidget {
  @override
  _DesignerScreenState createState() => _DesignerScreenState();
}

class _DesignerScreenState extends State<DesignerScreen> {
  String stoleColor = "#C9A227";
  String studentName = "محمد أمين";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('صمم روبك - Toga DZ')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: ModelViewer(
              src: 'assets/models/robe.glb',
              alt: "روب تخرج 3D",
              autoRotate: true,
              cameraControls: true,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'اسمك للتطريز'),
                    onChanged: (v) => setState(() => studentName = v),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      colorBtn("#800020", "عنابي"),
                      colorBtn("#000000", "أسود"),
                      colorBtn("#006233", "أخضر"),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: saveDesign,
                    child: Text('حفظ التصميم'),
                    style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget colorBtn(String hex, String label) {
    return ElevatedButton(
      onPressed: () => setState(() => stoleColor = hex),
      child: Text(label),
    );
  }

  void saveDesign() {
    final design = {"stole_color": stoleColor, "name_ar": studentName};
    print(design);
  }
}
