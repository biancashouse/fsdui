import 'package:dart_mappable/dart_mappable.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/snodes/dynamic_tabbar_node.dart';
import 'package:fsdui/src/snippet/snodes/tabdata_node.dart';

part 'abstract_sc_node.mapper.dart';

@MappableClass(discriminatorKey: 'DK:sc', includeSubClasses: singleChildSubClasses,
  hook: PropertyRenameHook('sc', 'DK:sc'), // 'first_name' -> JSON key, 'firstName' -> Dart field name
)
abstract class SC extends SNode with SCMappable {
  SNode? child;

  SC({super.name, this.child});

  @override
  bool canAppendAChild() => child == null;
}
