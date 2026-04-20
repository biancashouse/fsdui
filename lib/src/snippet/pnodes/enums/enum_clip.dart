import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/stack_clip_editor.dart';

part 'enum_clip.mapper.dart';

@MappableEnum()
enum ClipEnum {
  hardEdge(Clip.hardEdge),
  antiAlias(Clip.antiAlias),
  antiAliasWithSaveLayer(Clip.antiAliasWithSaveLayer);

  const ClipEnum(this.flutterValue);

  final Clip flutterValue;

  String toSource() => 'Clip.$name';

  static Widget propertyNodeContents({
    int? enumValueIndex,
    required SNode snode,
    required String label,
    ValueChanged<int?>? onChangedF,
  }) =>
      SizedBox(
        width: 280,
        height: 100,
        child: Column(
          children: [
            fsdui.coloredText('clip:', color: Colors.white),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                fsdui.coloredText('hardEdge', color: Colors.white),
                fsdui.coloredText('antiAlias', color: Colors.white),
                fsdui.coloredText('antiAlias\nWithSaveLayer', color: Colors.white),
              ],
            ),
            StackClipEditor(
              originalValue: ClipEnum.of(enumValueIndex),
              onChangedF: (ClipEnum? newValue) {
                onChangedF?.call(newValue?.index);
              },
            ),
          ],
        ),
      );

  // @override
  // Clip toWidget({ThemeData? themeData}) {
  //   return switch (this) {
  //     ClipEnum.hardEdge => Clip.hardEdge,
  //     ClipEnum.antiAlias => Clip.antiAlias,
  //     ClipEnum.antiAliasWithSaveLayer => Clip.antiAliasWithSaveLayer,
  //   };
  // }

  Widget toMenuItem() => fsdui.coloredText(name, color: Colors.white);

  static ClipEnum? of(int? index) => index != null ? ClipEnum.values.elementAtOrNull(index) : null;
}
