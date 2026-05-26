import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main()=>runApp(const MaterialApp(debugShowCheckedModeBanner:false,home:Designer()));

class Designer extends StatefulWidget{const Designer({super.key});@override State<Designer> createState()=>_DesignerState();}
class _DesignerState extends State<Designer>{
  late final WebViewController ctrl;
  String color="#C9A227"; bool auto=true;
  final colors=[["#C9A227","ذهبي",Colors.amber.shade700],["#800020","عنابي",const Color(0xFF800020)],["#000000","أسود",Colors.black],["#006233","أخضر",const Color(0xFF006233)],["#4B0082","نيلي",const Color(0xFF4B0082)]];
  @override void initState(){super.initState();ctrl=WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..loadFlutterAsset('assets/3d_viewer.html');}
  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('صمم روبك - Toga DZ'),backgroundColor:Colors.deepPurple,foregroundColor:Colors.white,actions:[IconButton(icon:Icon(auto?Icons.pause:Icons.play_arrow),onPressed:(){setState(()=>auto=!auto);ctrl.runJavaScript('window.receiveFromFlutter("setAutoRotate", $auto)');})]),
    body:Column(children:[
      Expanded(flex:4,child:WebViewWidget(controller:ctrl)),
      Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.grey.shade50,borderRadius:const BorderRadius.vertical(top:Radius.circular(20))),child:Column(children:[
        TextField(decoration:InputDecoration(labelText:'اسمك للتطريز',prefixIcon:const Icon(Icons.person),border:OutlineInputBorder(borderRadius:BorderRadius.circular(12))),textAlign:TextAlign.right),
        const SizedBox(height:12),
        Row(children:[const Text('لون الوشاح:',style:TextStyle(fontWeight:FontWeight.bold)),const SizedBox(width:10),Expanded(child:SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children:colors.map((c)=>GestureDetector(onTap:(){setState(()=>color=c[0] as String);ctrl.runJavaScript('window.receiveFromFlutter("changeColor","${c[0]}")');},child:Container(margin:const EdgeInsets.symmetric(horizontal:4),width:40,height:40,decoration:BoxDecoration(color:c[2] as Color,shape:BoxShape.circle,border:Border.all(color:color==c[0]?Colors.deepPurple:Colors.transparent,width:3))))).toList()))))]),
        const SizedBox(height:12),
        SizedBox(width:double.infinity,child:ElevatedButton.icon(onPressed:(){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('تم حفظ التصميم! 🎓')));},icon:const Icon(Icons.save),label:const Text('حفظ التصميم'),style:ElevatedButton.styleFrom(backgroundColor:Colors.deepPurple,foregroundColor:Colors.white,padding:const EdgeInsets.symmetric(vertical:14))))
      ]))
    ])
  );
}
