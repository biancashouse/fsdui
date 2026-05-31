import 'package:fsdui/fsdui.dart';

mixin SC on SNode {

  abstract SNode? child;

  @override
  bool canAppendAChild() => child == null;
}
