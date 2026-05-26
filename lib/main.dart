import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toga DZ',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const Toga3DViewerScreen(),
    );
  }
}

class Toga3DViewerScreen extends StatefulWidget {
  const Toga3DViewerScreen({super.key});
  @override State<Toga3DViewerScreen> createState() => _Toga3DViewerScreenState();
}

class _Toga3DViewerScreenState extends State<Toga3DViewerScreen> {
  final Flutter3DController controller = Flutter3DController();
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toga DZ - Concepteur 3D'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: Column(children: [
        Expanded(flex:3, child: Stack(children: [
          Container(margin: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12)]),
            child: ClipRRect(borderRadius: BorderRadius.circular(24),
              child: Flutter3DViewer(controller: controller, src: 'assets/models/robe.glb',
                onProgress: (p){ if(p>=1 && loading) setState(()=>loading=false); },
              ),
            ),
          ),
          if(loading) const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[CircularProgressIndicator(), SizedBox(height:12), Text('جاري تحميل النموذج 3D...')]))
        ])),
        Expanded(flex:2, child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Votre nom pour la broderie", style: TextStyle(fontSize:16,fontWeight:FontWeight.w600)),
          const SizedBox(height:8),
          TextField(decoration: InputDecoration(hintText:"Ex: Amina B.", filled:true, fillColor:Colors.white, border:OutlineInputBorder(borderRadius:BorderRadius.circular(14), borderSide:BorderSide.none))),
          const Spacer(),
          SizedBox(width:double.infinity,height:54, child: ElevatedButton.icon(onPressed:(){}, icon:const Icon(Icons.check), label:const Text("Enregistrer le design"), style:ElevatedButton.styleFrom(backgroundColor:Colors.deepPurple, foregroundColor:Colors.white)))
        ])))
      ]),
    );
  }
}
