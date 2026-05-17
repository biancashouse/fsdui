import 'package:fsdui/src/model/alignment_enum_model.dart';
import 'package:fsdui/src/model/color_model.dart';
import 'package:fsdui/src/snippet/pnodes/groups/container_style_properties.dart';
import 'package:fsdui/src/snippet/pnodes/groups/text_style_properties.dart';
import 'package:fsdui/src/snippet/snode.dart';
import 'package:fsdui/src/snippet/snodes/abstract_mc_node.dart';
import 'package:fsdui/src/snippet/snodes/abstract_sc_node.dart';
import 'package:fsdui/src/snippet/snodes/container_node.dart';
import 'package:fsdui/src/snippet/snodes/edgeinsets_node_value.dart';
import 'package:fsdui/src/snippet/snodes/row_node.dart';
import 'package:fsdui/src/snippet/snodes/text_node.dart';
import 'package:fsdui/src/snippet/snodes/upto6colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    SNodeMapper.ensureInitialized();
    SCMapper.ensureInitialized();
    MCMapper.ensureInitialized();
    ContainerNodeMapper.ensureInitialized();
    TextNodeMapper.ensureInitialized();
    RowNodeMapper.ensureInitialized();
    ContainerStylePropertiesMapper.ensureInitialized();
    TextStylePropertiesMapper.ensureInitialized();
    EdgeInsetsValueMapper.ensureInitialized();
    UpTo6ColorsMapper.ensureInitialized();
    ColorModelMapper.ensureInitialized();
  });

  group('SNode Serialization Tests', () {
    test('ContainerNode serializes and deserializes correctly', () {
      // 1. Arrange: Create a complex node structure.
      final originalNode = ContainerNode(
        csPropGroup: ContainerStyleProperties(
          width: 150.0,
          height: 80.0,
          margin: EdgeInsetsValue(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
          padding: EdgeInsetsValue(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
          alignment: AlignmentEnum.center,
          fillColors: UpTo6Colors(color1: ColorModel.blue()), // Blue
          borderColors: UpTo6Colors(color1: ColorModel.black()), // Black
          borderThickness: 2.0,
          borderRadius: 12.0,
          radialGradient: true,
        ),
        child: TextNode(text: 'Test', tsPropGroup: TextStyleProperties()),
      );

      // 2. Act: Serialize then deserialize, then re-serialize.
      final jsonMap = originalNode.toMap();
      final decodedNode = ContainerNodeMapper.fromMap(jsonMap);

      // 3. Assert: The roundtrip is lossless — both nodes serialize to the
      // same map. We compare maps rather than objects because SNode.uid is a
      // runtime-generated field (not serialized) that differs between instances.
      expect(decodedNode.toMap(), equals(originalNode.toMap()));
    });

    test('RowNode with multiple children serializes and deserializes correctly', () {
      // 1. Arrange
      final originalNode = RowNode(
        children: [
          TextNode(text: 'Hello', tsPropGroup: TextStyleProperties()),
          ContainerNode(
            csPropGroup: ContainerStyleProperties(width: 50, height: 50),
            child: TextNode(text: 'World', tsPropGroup: TextStyleProperties()),
          ),
        ],
      );

      // 2. Act
      final jsonMap = originalNode.toMap();
      final decodedNode = RowNodeMapper.fromMap(jsonMap);

      // 3. Assert
      expect(decodedNode.toMap(), equals(originalNode.toMap()));
      expect(decodedNode.children.length, 2);
      expect(decodedNode.children[0], isA<TextNode>());
      expect((decodedNode.children[1] as ContainerNode).child, isA<TextNode>());
    });

    // Add more tests for other SNode types...
  });
}
