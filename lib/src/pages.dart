import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsdui/fsdui.dart';
import 'package:go_router/go_router.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    fsdui.logger.d('pages build');
    var pages = fsdui.pageList;
    final scaffold = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Available Pages in this web app')),
      body: ListView.builder(
        padding: EdgeInsets.all(30),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final label = pages[index];
          String sandboxIndicator =
              (fsdui.appInfo.anonymousUserEditablePages.contains(label))
              ? ' *'
              : "";
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (label != '/')
                IconButton(
                  onPressed: () async {
                    fsdui.appInfo.snippetNames.remove(label);
                    fsdui.appInfo.anonymousUserEditablePages.remove(label);
                    fsdui.deleteSubRoute(path: label);
                    await fsdui.modelRepo.saveAppInfo();
                    await fsdui.modelRepo.deleteSnippet(label);
                    fsdui.appInfo.removeFromCache(label);
                    fsdui.capiBloc.add(CAPIEvent.forceRefresh());
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              TextButton(
                onPressed: () {
                  context.go(label);
                },
                child: Text('    $label$sandboxIndicator'),
              ),
            ],
          );
        },
      ),
    );

    return BlocBuilder<CAPIBloC, CAPIState>(
      builder: (context, state) {
        bool showPencil = !fsdui.canEditAnyContent();
        return Stack(
          children: [
            scaffold,
            if (showPencil)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    // ask user to sign in as editor
                    EditablePage.of(context)?.editorPasswordDialog();
                    fsdui.capiBloc.add(CAPIEvent.forceRefresh());
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }
}
