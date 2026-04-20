import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // fco.logger.d('MyTest didPush: $route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // fco.dismissAll();
    if (fsdui.snippetBeingEdited != null) {
      fsdui.capiBloc.add(PopSnippetEditor());
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // fco.logger.d('MyTest didRemove: $route');
    // fco.dismissAll();
    if (fsdui.snippetBeingEdited != null) {
      fsdui.capiBloc.add(PopSnippetEditor());
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // fco.logger.d('MyTest didReplace: $newRoute');
  }
}
