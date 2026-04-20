import 'package:flutter/material.dart';

import 'package:fsdui/fsdui.dart';

class Page_IframeTest extends StatelessWidget {
  const Page_IframeTest({super.key});

  @override
  Widget build(BuildContext context) {
    SnippetBuilder sp = SnippetBuilder(
      initialValue: IFrameNode(name: 'iframe-demo'),
      //sC.name, because no scrolling used
    );

    final scaffold = sp;

    return EditablePage(routePath: '/', key: GlobalKey(), child: scaffold);
  }
}
