import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

// flutter_quill's built-in h1/h2/h3 styles only add spacing *above* a
// heading (their verticalSpacing bottom is 0), so a heading sits flush
// against the text below it instead of having a gap like Google Docs etc.
// Lists have a similarly small default gap (lineSpacing bottom of just 6)
// between items, and plain paragraphs have *no* gap at all (verticalSpacing
// is VerticalSpacing.zero). DefaultStyles.merge() replaces a whole
// DefaultTextBlockStyle/DefaultListBlockStyle when the override is non-null,
// so each override below is built from the real defaults via copyWith
// rather than authored from scratch.
DefaultStyles quillHeadingGapStyles(
  BuildContext context, {
  required double h1Bottom,
  required double h2Bottom,
  required double h3Bottom,
  required double listBottom,
  required double paragraphBottom,
}) {
  final defaults = DefaultStyles.getInstance(context);

  DefaultTextBlockStyle? withBottomGap(
    DefaultTextBlockStyle? style,
    double bottom,
  ) {
    if (style == null) return null;
    return style.copyWith(
      verticalSpacing: VerticalSpacing(style.verticalSpacing.top, bottom),
    );
  }

  return DefaultStyles(
    h1: withBottomGap(defaults.h1, h1Bottom),
    h2: withBottomGap(defaults.h2, h2Bottom),
    h3: withBottomGap(defaults.h3, h3Bottom),
    paragraph: withBottomGap(defaults.paragraph, paragraphBottom),
    lists: defaults.lists?.copyWith(
      // lineSpacing is *between* items; verticalSpacing is the block-level
      // gap before the first item and after the last one. The gap after the
      // last item should read the same as the gap after any other
      // paragraph, so it reuses paragraphBottom rather than listBottom.
      lineSpacing: VerticalSpacing(
        defaults.lists!.lineSpacing.top,
        listBottom,
      ),
      verticalSpacing: VerticalSpacing(
        defaults.lists!.verticalSpacing.top,
        paragraphBottom,
      ),
    ),
  );
}
