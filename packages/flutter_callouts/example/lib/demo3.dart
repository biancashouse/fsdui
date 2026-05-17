import 'package:flutter/material.dart';
import 'package:flutter_callouts/flutter_callouts.dart';

void main() => runApp(
  const FlutterCalloutsApp(
    title: 'flutter_callouts demo',
    home: Demo3(),
  ),
);

class Demo3 extends StatefulWidget {
  const Demo3({super.key});

  @override
  State<Demo3> createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  GlobalKey gk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast Tester')),
      body: Center(child: FilledButton(onPressed: (){
        fca.showToast(msg: 'spank', textColor: Colors.blue, bgColor: Colors.yellow, removeAfterMs: 3000);
      }, child: Text('show toast')),),
    );
  }
}
