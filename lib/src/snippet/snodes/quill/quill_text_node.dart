// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/model/quill_target_model.dart';
import 'package:fsdui/src/snippet/pnodes/decimal_pnode.dart';
import 'package:fsdui/src/snippet/pnodes/fyi_pnodes.dart';

// import 'package:fsdui/src/snippet/pnodes/quill_text_pnode.dart';
import 'package:fsdui/src/snippet/snodes/quill/widgets/quill_default_styles.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fsdui/src/snippet/snodes/quill/widgets/quill_viewer.dart' show QuillViewer;
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../pnodes/edgeinsets_pnode.dart';
import 'widgets/focus_aware_quill_editor.dart';

part 'quill_text_node.mapper.dart';

const k_emptyDeltaJsonString = '[{"insert":"\\n"}]';

@MappableClass()
class QuillTextNode extends SNode with QuillTextNodeMappable {
  String deltaJsonString;

  // Gap below h1/h2/h3 headings and between list items. flutter_quill's
  // built-in heading styles only add spacing *above* a heading, so these
  // give control over the (missing) spacing below, Google-Docs style. See
  // quillHeadingGapStyles() in quill_default_styles.dart.
  double h1BottomGap;
  double h2BottomGap;
  double h3BottomGap;
  double listItemGap;

  // Gap below a plain paragraph. flutter_quill's default paragraph style
  // has *no* spacing at all (top or bottom), so paragraphs sit flush
  // against each other unless this is set.
  double paragraphBottomGap;
  EdgeInsets? padding;

  QuillTextNode({
    super.name,
    this.deltaJsonString = k_emptyDeltaJsonString,
    this.h1BottomGap = 16.0,
    this.h2BottomGap = 12.0,
    this.h3BottomGap = 8.0,
    this.listItemGap = 8.0,
    this.paragraphBottomGap = 16.0,
    this.padding,
  });

  CalloutId get quillTextToolbarCID => 'quill-toolbar-$uid';

  /// The rendered size of this node's widget, or null if it hasn't been
  /// laid out yet (e.g. not built, or not yet attached to the tree).
  Size? get size => nodeWidgetGK
      ?.globalPaintBounds(
        skipWidthConstraintWarning: true,
        skipHeightConstraintWarning: true,
      )
      ?.size;

  // keep transient copy of each Embed's  gk
  // @JsonKey(includeFromJson: false, includeToJson: false)
  // Map<String,GlobalKey> targetGks = {};

  @override
  List<PNode> propertyNodes(BuildContext context, SNode? parentSNode) {
    return [
      FlutterDocPNode(
        buttonLabel: 'Quill',
        webLink: 'https://pub.dev/packages/flutter_quill',
        snode: this,
        name: 'fyi',
      ),
      EdgeInsetsPNode(
        snode: this,
        name: 'padding',
        ei: padding,
        onEIChangedF: (newEI) =>
            refreshWithUpdate(context, () => padding = newEI),
      ),
      DecimalPNode(
        snode: this,
        name: 'h1BottomGap',
        decimalValue: h1BottomGap,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => h1BottomGap = newValue ?? 16.0),
      ),
      DecimalPNode(
        snode: this,
        name: 'h2BottomGap',
        decimalValue: h2BottomGap,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => h2BottomGap = newValue ?? 12.0),
      ),
      DecimalPNode(
        snode: this,
        name: 'h3BottomGap',
        decimalValue: h3BottomGap,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => h3BottomGap = newValue ?? 8.0),
      ),
      DecimalPNode(
        snode: this,
        name: 'listItemGap',
        decimalValue: listItemGap,
        onDoubleChange: (newValue) =>
            refreshWithUpdate(context, () => listItemGap = newValue ?? 8.0),
      ),
      DecimalPNode(
        snode: this,
        name: 'paragraphBottomGap',
        decimalValue: paragraphBottomGap,
        onDoubleChange: (newValue) => refreshWithUpdate(
          context,
          () => paragraphBottomGap = newValue ?? 8.0,
        ),
      ),
      // QuillTextPNode(
      //   snode: this,
      //   name: 'data',
      //   deltaValue: deltaJsonString,
      //   onDeltaChange: (String? newValue) {
      //     refreshWithUpdate(context, () => deltaJsonString = newValue ?? '');
      //   },
      //   calloutButtonSize: const Size(280, 3000),
      //   calloutWidth: fco.scrW * .8,
      //   calloutHeight: fco.scrH * .8,
      // ),
    ];
  }

  @override
  Widget buildFlutterWidget(BuildContext context, SNode? parentNode) {
    // targetGks = {};

    setParent(parentNode);

    var gk = createNodeWidgetGK();

    Widget editor;

    if (fsdui.canEditAnyContent() &&
        fsdui.snippetBeingEdited == null &&
        !fsdui.capiBloc.showTappableBorderRects()) {
      editor = Material(
        child: FocusAwareQuillEditor(
          key: gk,
          parentSNode: this,
          uid: uid,
          originalDeltaJsonString: deltaJsonString,
          onChange: (String newValue, {bool forceRefresh = false}) {
            deltaJsonString = newValue;
            snippetInfo()?.notifyChange(rootNodeOfSnippet()!);
          },
          onChangeImmediate: (String newValue, bool isPending) {
            deltaJsonString = newValue;
            snippetInfo()?.changesPendingNotifier.value = isPending;
          },
          // onEditWithToolbarBtnPressed: () {
          //   final rootNode = rootNodeOfSnippet();
          //   if (rootNode != null) {
          //     showQuillEditorOverlay(
          //       quillTextNode: this,
          //       onChangeF: (String? newValue) {
          //         refreshWithUpdate(
          //           context,
          //           () => deltaJsonString = newValue ?? '',
          //         );
          //         fco.forceRefresh();
          //       },
          //     );
          //   }
          // },
        ),
      );
    } else {
      // use a quill viewer or Html widget to show the read-only quilltext
      final useHtml = false;

      if (useHtml) {
        final deltaOps = List<Map<String, dynamic>>.from(
          jsonDecode(deltaJsonString),
        );

        // inlineStylesFlag forces attributes like `font` to be emitted as
        // inline `style="font-family:..."` rather than a CSS class (e.g.
        // `class="ql-font-Merriweather"`). flutter_html has no CSS engine to
        // resolve classes against a stylesheet, so class-based font/size/align
        // attributes are silently dropped; inline styles are the only form it
        // can actually read.
        final converter = QuillDeltaToHtmlConverter(
          deltaOps,
          ConverterOptions(
            converterOptions: OpConverterOptions(inlineStylesFlag: true),
          ),
        );

        editor = Html(
          data: converter.convert(),
          style: quillHeadingGapHtmlStyles(
            h1Bottom: h1BottomGap,
            h2Bottom: h2BottomGap,
            h3Bottom: h3BottomGap,
            listBottom: listItemGap,
            paragraphBottom: paragraphBottomGap,
          ),
        );
      } else {
        editor = QuillViewer(key: gk, parentSNode: this);
      }
    }

    // for safety, if parent is a flex, wrap with an Expanded widget
    return parentNode is FlexNode ? Expanded(child: editor) : editor;
  }

  // Assume you have a QuillController instance
  // final QuillController _controller = QuillController.basic();

  static List<QuillTargetModel> getTargetList(String deltaJsonString) {
    List<QuillTargetModel> targets = [];

    final doc = Document.fromJson(jsonDecode(deltaJsonString));

    // Convert the document to a list of JSON operations (Delta format)
    List<Map<String, dynamic>> ops = doc.toDelta().toJson();

    for (var op in ops) {
      // Check if the operation is an insert operation and contains an embed type
      if (op.containsKey('insert') && op['insert'] is Map) {
        Map<String, dynamic> insertData = op['insert'];

        // Look for known embed types like 'image', 'video', or custom types
        insertData.forEach((type, value) {
          if (type == 'custom') {
            final customMap = jsonDecode(value);
            if (customMap.containsKey('quill-help-icon-button')) {
              final embed = jsonDecode(customMap['quill-help-icon-button']);
              final qt = QuillTargetModelMapper.fromMap(embed);
              targets.add(qt);
            }
          }
        });
      }
    }

    return targets;
  }

  @override
  String toString() => FLUTTER_TYPE;

  static const String FLUTTER_TYPE = "QuillText";
}
