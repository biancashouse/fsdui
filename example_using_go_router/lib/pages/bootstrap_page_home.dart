// import 'package:flutter/material.dart';
// import 'package:fsdui/fsdui.dart';
// import 'package:responsive_bootstrap_ui/responsive_bootstrap_ui.dart';
//
// class DemoPage extends StatelessWidget {
//   const DemoPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Bootstrap Grid Example"),
//         actions: [
//           fsdui.NavigationDD(pencilIconColor: Colors.red),
//           SizedBox(width: 10, height: 1),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             BootstrapRow(
//                 children: [
//                   BootstrapCol(
//                     md: 6,
//                     lg: 3,
//                     xl: 4,
//                     child: SnippetBuilder(
//                       initialValue: ContainerNode(name: 'container-temp', csPropGroup: ContainerStyleProperties(
//                         height: 300, fillColors: UpTo6Colors(color1: Colors.red)
//                       )),
//                     ),
//                   ),
//                   BootstrapCol(md: 6, lg: 3, xl: 4, child:
//                   SnippetBuilder(
//                     initialValue: ContainerNode(name: 'yt-temp', csPropGroup: ContainerStyleProperties(
//                         height: 300, fillColors: UpTo6Colors(color1: Colors.red),
//                     ),
//                     child: YTNode()),
//                   ),),
//                   BootstrapCol(md: 12, lg: 6, xl: 4, child: _box("Three")),
//                 ],
//               ),
//             const SizedBox(height: 20),
//             BootstrapRow(
//               children: [
//                 BootstrapCol(md: 6, lg: 6, xl: 6, child: _box("One")),
//                 BootstrapCol(md: 6, lg: 6, xl: 6, child: _box("Two")),
//               ],
//             ),
//             const SizedBox(height: 20),
//             BootstrapRow(
//               children: [
//                 BootstrapCol(md: 6, lg: 4, xl: 3, child: _box("One")),
//                 BootstrapCol(md: 6, lg: 4, xl: 3, child: _box("Two")),
//                 BootstrapCol(md: 6, lg: 4, xl: 3, child: _box("Three")),
//                 BootstrapCol(md: 6, lg: 4, xl: 3, child: _box("Four")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _box(String text) => Container(
//     padding: const EdgeInsets.all(20),
//     decoration: BoxDecoration(
//       color: Colors.blue.shade100,
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
//   );
// }
