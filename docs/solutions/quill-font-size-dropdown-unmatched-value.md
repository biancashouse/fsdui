# Quill toolbar font-size dropdown ignored non-preset values

**File(s):** `lib/src/snippet/snodes/quill/widgets/quill_text_toolbar/quill_text_toolbar.dart`

## Problem

The font-size button in `QuillTextToolbar` always displayed the static
`"Size"` placeholder instead of the current font size, whenever that size
fell outside a small fixed set of presets (`10, 12, 14, 16, 18, 24, 36`) —
for example, text pasted or imported with a custom inline size.

## Root Cause

`_QuillAttributeMenuButton` is a shared dropdown component used for the
font-family, font-size, and header-style buttons. Its `_currentValue` getter
resolves a display label purely by matching the current Quill attribute
value against the fixed `items` preset map passed in by the caller:

```dart
String get _currentValue {
  final attribute = widget.controller
      .getSelectionStyle()
      .attributes[widget.attributeKey];
  if (attribute == null) return widget.defaultDisplayText;
  for (final entry in widget.items.entries) {
    if (widget.parseValue(entry.value) == attribute.value) return entry.key;
  }
  return widget.defaultDisplayText; // <- actual value silently discarded here
}
```

When a size was set but didn't match any preset, the loop found no match and
fell straight back to `defaultDisplayText`, discarding the real value even
though it was available on the attribute.

## Strategy

Added an optional `formatUnmatchedValue: String Function(dynamic value)?`
callback to `_QuillAttributeMenuButton`. When no preset matches, this
callback formats the raw attribute value for display (e.g. `20.0` → `"20"`)
instead of falling back to the placeholder text. Wired it in only for the
size dropdown — the font-family and header-style dropdowns have a fixed,
exhaustive value domain where "unmatched" isn't expected to happen, so they
were left using the plain fallback.
