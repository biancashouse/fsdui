import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';
import 'package:fsdui/src/snippet/pnodes/string_pnode.dart';

part 'crossword_node.mapper.dart';

@MappableClass()
class CrosswordNode extends CL with CrosswordNodeMappable {
  String? type; // e.g., 'nyt' or 'the_guardian'
  String? jsonData; // JSON containing layout, clues, and answers

  CrosswordNode({
    super.name,
    this.type,
    this.jsonData,
  });

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) => [
        // Type Selection
        StringPNode(
          snode: this,
          name: 'type',
          stringValue: type,
          onStringChange: (newValue) =>
              refreshWithUpdate(context, () => type = newValue),
          calloutButtonSize: const Size(280, 70),
          calloutWidth: 300,
        ),
        // JSON Data
        StringPNode(
          snode: this,
          name: 'jsonData',
          stringValue: jsonData,
          onStringChange: (newValue) =>
              refreshWithUpdate(context, () => jsonData = newValue),
          calloutButtonSize: const Size(280, 70),
          calloutWidth: 300,
        ),
        // Example: Might need more property nodes here for structured data.
      ];

  @override
  Widget build(BuildContext context, SNode? parentNode,
      ) {
    try {
      setParent(parentNode); // propagating parents down from root

      return Center(
        key: createNodeWidgetGK(),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Crossword Puzzle (${type ?? 'Unknown'})', 
                   style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              // Placeholder for actual crossword puzzle rendering
              Text('Clues Source: ${type ?? 'N/A'}'),
              const SizedBox(height: 10),
              // Displaying the JSON structure for inspection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('JSON Data Preview:\n${jsonData ?? 'No JSON provided'}'),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Error(
          key: createNodeWidgetGK(),
          FLUTTER_TYPE,
          color: Colors.red,
          size: 16,
          errorMsg: e.toString());
    }
  }

  @override
  String toSource(BuildContext context) {
    return '''CrosswordNode(type:'$type', jsonData:'${jsonData}')''';
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "Crossword";
}