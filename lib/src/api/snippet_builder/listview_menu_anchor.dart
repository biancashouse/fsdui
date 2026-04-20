import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'tr_triangle_painter.dart' show TRTriangle;

class ListViewMenuAnchor extends StatelessWidget {
  final ListViewNode node;

  const ListViewMenuAnchor({required this.node, super.key});

  @override
  Widget build(BuildContext context) {
    final snippetInfo = node.snippetInfo;
    if (snippetInfo == null) return const Offstage();
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
            return Tooltip(
              message: 'add article',
              child: InkWell(
                onTap: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                child: CustomPaint(
                  size: const Size(40, 40),
                  painter: TRTriangle(Colors.deepPurpleAccent),
                ),
              ),
            );
          },
      menuChildren: [
        // SubmenuButton(
        //     menuChildren: revertMIs, child: const Text('revert staging...')),
        _menuItemButtonWithPI(
          onPressed: () async {
            fsdui.capiBloc.add(
              CAPIEvent.toggleSnippetVisibility(snippetName: snippetInfo.name),
            );
          },
          child: Text(
            '${snippetInfo.hide ?? false ? 'show' : 'hide'} snippet',
          ),
        ),
      ],
    );
  }

  MenuItemButton _menuItemButtonWithPI({
    required Widget child,
    required VoidCallback onPressed,
  }) => MenuItemButton(
    onPressed: onPressed,
    child: Align(
      alignment: Alignment.centerLeft,
      child: PointerInterceptor(child: child),
    ),
  );
}
