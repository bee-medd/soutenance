import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main()=>runApp(MaterialApp(home:Toga3D()));

class Toga3D extends StatefulWidget{ @override State<Toga3D> createState()=>_Toga3DState();}
class _Toga3DState extends State<Toga3D>{
  late final WebViewController ctrl;
  @override void initState(){super.initState(); ctrl=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadFlutterAsset('assets/web/index.html');}
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:Text('Toga DZ - 3D'),backgroundColor:Colors.deepPurple,foregroundColor:Colors.white),
    body:Column(children:[
      Expanded(child:Container(margin:EdgeInsets.all(16),decoration:BoxDecoration(borderRadius:BorderRadius.circular(24)),clipBehavior:Clip.antiAlias,child:WebViewWidget(controller:ctrl))),
      Padding(padding:EdgeInsets.all(16),child:TextField(decoration:InputDecoration(labelText:'Votre nom',border:OutlineInputBorder())))
    ])
  );
}
