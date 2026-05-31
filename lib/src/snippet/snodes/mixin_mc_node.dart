import 'package:fsdui/fsdui.dart';

mixin MC on SNode {
  abstract List<SNode> children;

    @override
  bool canRemove() => children.length < 2;

  @override
  bool canAppendAChild() => true;
}
