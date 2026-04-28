# Algorithm Renderer — Project Resurrection Prompt

This document contains everything needed to reconstruct this project from
scratch with an AI assistant. Paste it as the first message in a new session,
then attach the three artefacts listed below.

---

## Artefacts to Attach

1. `algorithm.schema.json` — the JSON Schema for the Algorithm data model
2. `GEOMETRY.md` — the visual geometry specification for rendering algorithms
3. `algorithm_svg.dart` — the Dart/Flutter SVG renderer + validator

---

## Project Summary

We are building tooling around a data model called **Algorithm** — a structured,
JSON-serialisable representation of an algorithm as a tree of typed steps.

The project has three layers:

### 1. Data Model (`algorithm.schema.json`)
A JSON Schema (draft 2020-12) describing an `Algorithm` object and all its
constituent `Step` types. The schema is the source of truth for the data model.

**Algorithm** has: `name` (string), `description` (string), optional
`parameters` (array of `Parameter`), and `steps` (array of `Step`).

**Parameter** has: `name`, `type`, optional `description`, optional `default`.

**Step** is an abstract type discriminated by a `"type"` string field.
The concrete step types are:

| Schema type        | Description |
|--------------------|-------------|
| `Action`           | A plain step with a `txt` display string |
| `Loop`             | A `txt` label + a `steps` array of child steps; renders with a U-arc |
| `Decision`         | A `condition` string + `trueSteps` + `falseSteps` arrays; renders with a diamond |
| `Function`         | A named (`id`, `name`, optional `description`, optional `parameters`) reusable block with a `steps` array |
| `AwaitFunctionCall`| Calls a `Function` by `functionId`, blocks until done; has optional `label`, `arguments` |
| `AsyncFunctionCall`| Calls a `Function` by `functionId` asynchronously; has optional `label`, `arguments`, plus `successSteps` + `failedSteps` arrays |
| `Return`           | Ends the current scope; has optional `label`, `value` (any type), `valueExpression` (string) |

**Key schema decisions:**
- `Function`, `AwaitFunctionCall`, `AsyncFunctionCall` all have indigo borders
  and inner vertical flanking lines in the rendered diagram.
- `AwaitFunctionCall` additionally shows a clock badge between the left rect
  border and the left flanking line.
- `Return` always renders its text prefixed with `"return "`.
- `Function` rect displays `name` only; `description` is for hover/tooltip.
- `Return` pill text priority: `label` → `valueExpression` → stringify `value` → `"return"`.
- `AwaitFunctionCall` and `AsyncFunctionCall` display `label` if present,
  else fall back to `functionId`.

**Schema ↔ renderer name mapping:**

| Schema type        | GEOMETRY.md renderer name  |
|--------------------|----------------------------|
| `Action`           | `ActionStep`               |
| `AwaitFunctionCall`| `AwaitActionStep`          |
| `AsyncFunctionCall`| `AsyncActionStepNode`      |
| `Function`         | `FunctionStep`             |
| `Loop`             | `LoopStepNode`             |
| `Decision`         | `DecisionStepNode`         |
| `Return`           | `ReturnStep`               |

---

### 2. Visual Geometry (`GEOMETRY.md`)
A precise pixel-level specification for rendering any Algorithm as an SVG
diagram. All measurements are multiples of `t = 14px` (the base font size).

Key concepts:
- **Scope lines** — vertical lines that steps hang off via horizontal tab lines.
- **Root scope** at `x = 4t`; steps tab off it with `hline` then `rect`.
- **True/success scope** — hangs right off a diamond/clock icon; first rect
  vertically centred on the icon's `cy`.
- **False/fail scope** — hangs below the icon; also uses `BRANCH_SCOPE_X_OFF`
  and `BRANCH_RECT_X_OFF` offsets (mirrors true/success layout).
- **Function scope** — straight vertical scope line below the function rect,
  not a U-arc.
- **Loop U-arc** — a rounded U-shape below the loop rect enclosing child steps.
- **Flanking lines** — inner vertical lines inside flanked rects
  (`Function`, `AwaitFunctionCall`, `AsyncFunctionCall`), with rects wider by `t`.
- **Suppress flanking** on the first child of a true/success scope.
- **Single-child scopes** — no vertical scope line, just the horizontal tab.
- **Z-order** — lines/arcs rendered first (behind), shapes second (in front).

---

### 3. Dart Implementation (`algorithm_svg.dart`)
A single self-contained Dart file with two public functions:

```dart
/// Validates a decoded Algorithm JSON map against the embedded schema.
/// Requires: json_schema: ^4.0.0 in pubspec.yaml
AlgorithmValidationResult validateAlgorithm(Map<String, dynamic> algorithm);

/// Converts a decoded Algorithm JSON map into a self-contained SVG string.
String algorithmToSvg(Map<String, dynamic> algorithm);
```

The file has no Flutter dependencies — it works in Flutter, Dart CLI, or
server contexts. The only pub dependency is `json_schema: ^4.0.0`.

The schema is embedded directly in the Dart file as `_kAlgorithmSchema` so
no asset loading is required for validation.

**To use in Flutter:**
```dart
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'algorithm_svg.dart';

final algorithm = jsonDecode(myAlgorithmJsonString) as Map<String, dynamic>;

final validation = validateAlgorithm(algorithm);
if (validation.isValid) {
  final svg = algorithmToSvg(algorithm);
  return SvgPicture.string(svg);
} else {
  print(validation.errors);
}
```

---

## React Renderer

A React/JSX artifact (`AlgorithmRenderer.jsx`) was also built as a live
preview tool with a side-by-side JSON editor. It implements the same layout
engine and geometry spec in JavaScript. This can be reconstructed from the
Dart file and GEOMETRY.md if needed — the two implementations are intentionally
kept in sync.

---

## Known Design Decisions & Rationale

| Decision | Rationale |
|----------|-----------|
| False/fail scope mirrors true/success layout | Symmetry — both branch types use `BRANCH_SCOPE_X_OFF` / `BRANCH_RECT_X_OFF`, not a plain `attachX + TAB` |
| `AwaitFunctionCall` is flanked | Visual consistency with `Function` and `AsyncFunctionCall` — all three are "call" types with indigo styling |
| Clock badge at `rectX + FLANK_INNER_OFF / 2` | Centres the badge in the strip between the left rect border and the left flanking line |
| Schema embeds rendering notes in `$comment` | Keeps rendering intent co-located with the schema without polluting validators |
| `Return` always prefixes `"return "` | Makes the pill immediately readable without needing to know the step type |
| `Function` shows `name` only in rect | `description` is richer content suited to hover/tooltip, not the diagram |

---

## What To Work On Next (suggestions)

- **Pan & zoom** on the React renderer (drag to pan, scroll/pinch to zoom)
- **Tooltips** — hover on `Function` to show `description`; hover on call
  steps to show `functionId` + `arguments`
- **SVG/PNG export** from the React renderer
- **Step selection** — click a step to inspect its full JSON
- **Flutter widget** — wrap `algorithmToSvg` in a Flutter widget with
  `flutter_svg` and optional tap-to-inspect
- **Round-trip editor** — edit the algorithm visually and serialise back to JSON