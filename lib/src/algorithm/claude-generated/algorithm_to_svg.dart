// algorithm_svg.dart
//
// Generates an SVG string from an Algorithm JSON object, and validates
// Algorithm JSON objects against the schema.
// Requires: json_schema: ^4.0.0 in pubspec.yaml
//
// Usage:
//   import 'algorithm_svg.dart';
//   final result = validateAlgorithm(myMap);
//   if (result.isValid) {
//     final svg = algorithmToSvg(myMap);
//   }

import 'dart:convert';
import 'dart:math' as math;
import 'package:json_schema/json_schema.dart';

// ─── Constants (GEOMETRY.md) ──────────────────────────────────────────────────

const double kT            = 14.0;
const double kCharW        = 0.6  * kT;
const double kPadX         = kT;
const double kPadY         = 0.6  * kT;
const double kLineGap      = 4.0;
const double kRowGap       = 1.5  * kT;
const double kTab          = 2.0  * kT;
const double kDHx          = kT;
const double kDHy          = kT;
const double kDCxOff       = 2.0  * kT;
const double kDCyOff       = 2.5  * kT;
const double kBranchScopeX = 4.0  * kT;
const double kBranchRectX  = 6.0  * kT;
const double kFalseTopGap  = 2.0  * kT;
const double kULOff        = 2.0  * kT;
const double kUROff        = 4.0  * kT;
const double kURadius      = kT;
const double kUPad         = kT;
const double kFlankInner   = kT / 2.0;
const double kFlankExtraW  = kT;
const double kFuncScopeOff = 2.0  * kT;
const double kBadgeR       = 0.55 * kT;
const double kPillLeft     = 2.0  * kT;
const double kRootScopeX   = kPillLeft + 2.0 * kT; // 4t
const double kPillH        = 1.5  * kT;

// ─── Colors ───────────────────────────────────────────────────────────────────

const String cBg           = '#FAFBFC';
const String cDot          = '#DDE3EA';
const String cLine         = '#A8B3BE';
const String cRectStroke   = '#A8B3BE';
const String cIndigo       = '#6366F1';
const String cText         = '#1F2937';
const String cPillBg       = '#F5F7FA';
const String cReturnFill   = '#FEF3C7';
const String cReturnStroke = '#D97706';
const String cReturnText   = '#D97706';
const String cAwaitBadge   = '#EEF2FF';
const String cWhite        = '#FFFFFF';

// ─── Primitives ───────────────────────────────────────────────────────────────

// All layout functions accumulate _Primitive objects which are later
// sorted by z-order and serialised into SVG elements.

abstract class _Primitive {}

class _HLine extends _Primitive {
  final double x1, x2, y;
  _HLine(this.x1, this.x2, this.y);
}

class _VLine extends _Primitive {
  final double x, y1, y2;
  _VLine(this.x, this.y1, this.y2);
}

class _Rect extends _Primitive {
  final double x, y, w, h;
  final bool indigo;
  final List<String> lines;
  final double textX, textY;
  _Rect(this.x, this.y, this.w, this.h,
      {required this.indigo,
        required this.lines,
        required this.textX,
        required this.textY});
}

class _ReturnPill extends _Primitive {
  final double x, y, w, h;
  final String text;
  _ReturnPill(this.x, this.y, this.w, this.h, this.text);
}

class _FlankLines extends _Primitive {
  final double x1, x2, y1, y2;
  _FlankLines(this.x1, this.x2, this.y1, this.y2);
}

class _AwaitBadge extends _Primitive {
  final double cx, cy;
  _AwaitBadge(this.cx, this.cy);
}

class _Diamond extends _Primitive {
  final double cx, cy;
  _Diamond(this.cx, this.cy);
}

class _Clock extends _Primitive {
  final double cx, cy;
  _Clock(this.cx, this.cy);
}

class _UArc extends _Primitive {
  final double leftX, rightX, topY, bottomY;
  _UArc(this.leftX, this.rightX, this.topY, this.bottomY);
}

class _BeginPill extends _Primitive {
  final double x, y, w;
  final String label;
  _BeginPill(this.x, this.y, this.w, this.label);
}

class _EndPill extends _Primitive {
  final double x, y, w;
  final String label;
  _EndPill(this.x, this.y, this.w, this.label);
}

// ─── Text helpers ─────────────────────────────────────────────────────────────

class _Measure {
  final double w, h;
  final List<String> lines;
  _Measure(this.w, this.h, this.lines);
}

_Measure _measureText(String text, {bool flanked = false}) {
  final lines = text.split('\n');
  final maxChars = lines.map((l) => l.length).reduce(math.max);
  final w = (maxChars * kCharW + 2 * kPadX).ceilToDouble() +
      (flanked ? kFlankExtraW : 0);
  final rawH =
      lines.length * kT + (lines.length - 1) * kLineGap + 2 * kPadY;
  final h = (rawH / kT).ceil() * kT;
  return _Measure(w, h, lines);
}

String _stepText(Map<String, dynamic> step) {
  switch (step['type'] as String) {
    case 'Action':
      return (step['txt'] as String?) ?? '';
    case 'Loop':
      return (step['txt'] as String?) ?? '';
    case 'Decision':
      return (step['condition'] as String?) ?? '';
    case 'Function':
      return (step['name'] as String?) ?? '';
    case 'AwaitFunctionCall':
      return (step['label'] as String?) ??
          (step['functionId'] as String?) ??
          '';
    case 'AsyncFunctionCall':
      return (step['label'] as String?) ??
          (step['functionId'] as String?) ??
          '';
    case 'Return':
      if (step['label'] != null) return 'return ${step['label']}';
      if (step['valueExpression'] != null) {
        return 'return ${step['valueExpression']}';
      }
      if (step['value'] != null) return 'return ${jsonEncode(step['value'])}';
      return 'return';
    default:
      return '';
  }
}

bool _isFlanked(Map<String, dynamic> step) {
  final t = step['type'] as String;
  return t == 'AsyncFunctionCall' ||
      t == 'Function' ||
      t == 'AwaitFunctionCall';
}

// ─── Layout result ────────────────────────────────────────────────────────────

class _LayoutResult {
  final List<_Primitive> primitives;
  final double rectY;
  final double rectH;
  final double bottomY;
  _LayoutResult(
      {required this.primitives,
        required this.rectY,
        required this.rectH,
        required this.bottomY});
}

class _ScopeResult {
  final List<_Primitive> primitives;
  final double bottomY;
  _ScopeResult(this.primitives, this.bottomY);
}

// ─── Layout engine ────────────────────────────────────────────────────────────

_ScopeResult _layoutScope(
    List steps, double attachX, double startY) {
  final primitives = <_Primitive>[];
  var y = startY;
  final tabYs = <double>[];

  for (final step in steps) {
    final s = step as Map<String, dynamic>;
    final result = _layoutStep(s, attachX + kTab, y);
    primitives.addAll(result.primitives);
    final midY = result.rectY + result.rectH / 2;
    tabYs.add(midY);
    primitives.add(_HLine(attachX, attachX + kTab, midY));
    y = result.bottomY + kRowGap;
  }

  if (tabYs.length >= 2) {
    primitives.add(_VLine(attachX, tabYs.first, tabYs.last));
  }

  return _ScopeResult(primitives, y - kRowGap);
}

_ScopeResult _layoutTrueScope(
    List steps, double decRectX, double dCY) {
  final scopeX = decRectX + kBranchScopeX;
  final rectX  = decRectX + kBranchRectX;
  final primitives = <_Primitive>[];
  final tabYs = <double>[];
  var y = 0.0;

  for (var i = 0; i < steps.length; i++) {
    final step = steps[i] as Map<String, dynamic>;
    final flanked = _isFlanked(step);
    final txt = _stepText(step);
    final m = _measureText(txt, flanked: flanked);

    if (i == 0) y = dCY - m.h / 2;

    // suppress flanking on first child
    final result = _layoutStep(step, rectX, y, suppressFlanking: i == 0);
    primitives.addAll(result.primitives);
    final midY = result.rectY + result.rectH / 2;
    tabYs.add(midY);
    primitives.add(_HLine(scopeX, rectX, midY));
    y = result.bottomY + kRowGap;
  }

  if (tabYs.length >= 2) {
    primitives.add(_VLine(scopeX, tabYs.first, tabYs.last));
  }

  return _ScopeResult(primitives, y - kRowGap);
}

_ScopeResult _layoutFalseScope(
    List steps, double dCX, double dCY, double successBottomY) {
  if (steps.isEmpty) return _ScopeResult([], successBottomY);

  final scopeX = dCX + kBranchScopeX;
  final rectX  = dCX + kBranchRectX;
  final primitives = <_Primitive>[];

  final firstStep = steps[0] as Map<String, dynamic>;
  final firstM = _measureText(_stepText(firstStep),
      flanked: _isFlanked(firstStep));
  final firstRectTop = successBottomY + kFalseTopGap;
  final firstMidY    = firstRectTop + firstM.h / 2;

  // vertical connector icon-bottom → first rect mid
  primitives.add(_VLine(dCX, dCY + kDHy, firstMidY));
  // horizontal connector → scope line
  primitives.add(_HLine(dCX, scopeX, firstMidY));

  final tabYs = <double>[];
  var y = firstRectTop;

  for (final step in steps) {
    final s = step as Map<String, dynamic>;
    final result = _layoutStep(s, rectX, y);
    primitives.addAll(result.primitives);
    final midY = result.rectY + result.rectH / 2;
    tabYs.add(midY);
    primitives.add(_HLine(scopeX, rectX, midY));
    y = result.bottomY + kRowGap;
  }

  if (tabYs.length >= 2) {
    primitives.add(_VLine(scopeX, tabYs.first, tabYs.last));
  }

  return _ScopeResult(primitives, y - kRowGap);
}

_ScopeResult _layoutFuncScope(
    List steps, double rectX, double rectBottom) {
  final scopeX     = rectX + kFuncScopeOff;
  final childRectX = rectX + kFuncScopeOff + kTab;
  final primitives = <_Primitive>[];
  final tabYs = <double>[];
  var y = rectBottom + kRowGap;

  for (final step in steps) {
    final s = step as Map<String, dynamic>;
    final result = _layoutStep(s, childRectX, y);
    primitives.addAll(result.primitives);
    final midY = result.rectY + result.rectH / 2;
    tabYs.add(midY);
    primitives.add(_HLine(scopeX, childRectX, midY));
    y = result.bottomY + kRowGap;
  }

  if (tabYs.length >= 2) {
    primitives.add(_VLine(scopeX, rectBottom, tabYs.last));
  } else if (tabYs.length == 1) {
    primitives.add(_VLine(scopeX, rectBottom, tabYs[0]));
  }

  return _ScopeResult(primitives, y - kRowGap);
}

_LayoutResult _layoutStep(
    Map<String, dynamic> step, double rectX, double rectY,
    {bool suppressFlanking = false}) {
  final primitives = <_Primitive>[];
  final txt     = _stepText(step);
  final flanked = _isFlanked(step) && !suppressFlanking;
  final m       = _measureText(txt, flanked: flanked);
  final w = m.w, h = m.h;
  var bottomY = rectY + h;

  final type     = step['type'] as String;
  final isIndigo = type == 'Function' ||
      type == 'AwaitFunctionCall' ||
      type == 'AsyncFunctionCall';
  final isReturn = type == 'Return';

  if (isReturn) {
    primitives.add(_ReturnPill(rectX, rectY, w, h, txt));
  } else {
    primitives.add(_Rect(
      rectX, rectY, w, h,
      indigo: isIndigo,
      lines: m.lines,
      textX: rectX + kPadX + (flanked ? kFlankInner : 0),
      textY: rectY + kPadY,
    ));
  }

  if (flanked) {
    primitives.add(_FlankLines(
      rectX + kFlankInner,
      rectX + w - kFlankInner,
      rectY + 2,
      rectY + h - 2,
    ));
  }

  if (type == 'AwaitFunctionCall') {
    primitives.add(_AwaitBadge(rectX + kFlankInner / 2, rectY + h / 2));
  }

  // ── Decision ──
  if (type == 'Decision') {
    final dCX = rectX + kDCxOff;
    final dCY = rectY + h + kDCyOff;
    primitives.add(_VLine(dCX, rectY + h, dCY - kDHy));
    primitives.add(_Diamond(dCX, dCY));
    primitives.add(_HLine(dCX + kDHx, rectX + kBranchScopeX, dCY));

    final trueSteps  = (step['trueSteps']  as List?) ?? [];
    final falseSteps = (step['falseSteps'] as List?) ?? [];

    final trueResult  = _layoutTrueScope(trueSteps, rectX, dCY);
    primitives.addAll(trueResult.primitives);

    final falseResult = _layoutFalseScope(falseSteps, dCX, dCY, trueResult.bottomY);
    primitives.addAll(falseResult.primitives);

    bottomY = math.max(trueResult.bottomY, falseResult.bottomY);
  }

  // ── AsyncFunctionCall ──
  if (type == 'AsyncFunctionCall') {
    final dCX = rectX + kDCxOff;
    final dCY = rectY + h + kDCyOff;
    primitives.add(_VLine(dCX, rectY + h, dCY - kDHy));
    primitives.add(_Clock(dCX, dCY));
    primitives.add(_HLine(dCX + kDHx, rectX + kBranchScopeX, dCY));

    final successSteps = (step['successSteps'] as List?) ?? [];
    final failedSteps  = (step['failedSteps']  as List?) ?? [];

    final successResult = _layoutTrueScope(successSteps, rectX, dCY);
    primitives.addAll(successResult.primitives);

    final failResult = _layoutFalseScope(failedSteps, dCX, dCY, successResult.bottomY);
    primitives.addAll(failResult.primitives);

    bottomY = math.max(successResult.bottomY, failResult.bottomY);
  }

  // ── Loop ──
  if (type == 'Loop') {
    final leftX  = rectX + kULOff;
    final rightX = rectX + kUROff;
    final topY   = rectY + h;
    final loopSteps = (step['steps'] as List?) ?? [];
    final loopResult = _layoutScope(loopSteps, rightX, topY + kRowGap);
    primitives.addAll(loopResult.primitives);
    final loopBottom = loopResult.bottomY + kUPad;
    primitives.add(_UArc(leftX, rightX, topY, loopBottom));
    bottomY = loopBottom + kRowGap;
  }

  // ── Function ──
  if (type == 'Function') {
    final funcSteps = (step['steps'] as List?) ?? [];
    final funcResult = _layoutFuncScope(funcSteps, rectX, rectY + h);
    primitives.addAll(funcResult.primitives);
    bottomY = funcResult.bottomY;
  }

  return _LayoutResult(
    primitives: primitives,
    rectY: rectY,
    rectH: h,
    bottomY: bottomY,
  );
}

// ─── Top-level layout ─────────────────────────────────────────────────────────

class _DiagramLayout {
  final List<_Primitive> primitives;
  final double width, height;
  _DiagramLayout(this.primitives, this.width, this.height);
}

_DiagramLayout _layoutAlgorithm(Map<String, dynamic> algorithm) {
  final primitives = <_Primitive>[];
  final steps = (algorithm['steps'] as List?) ?? [];
  final name  = (algorithm['name'] as String?) ?? 'Begin';

  // Begin pill
  final pillM = _measureText(name);
  primitives.add(_BeginPill(kPillLeft, kT * 2, pillM.w, name));
  final beginBottom = kT * 2 + kPillH;

  var y = beginBottom + kRowGap * 2;
  final tabYs = <double>[];

  for (final step in steps) {
    final s = step as Map<String, dynamic>;
    final result = _layoutStep(s, kRootScopeX + kTab, y);
    primitives.addAll(result.primitives);
    final midY = result.rectY + result.rectH / 2;
    tabYs.add(midY);
    primitives.add(_HLine(kRootScopeX, kRootScopeX + kTab, midY));
    y = result.bottomY + kRowGap;
  }

  // End pill
  const endLabel = 'End';
  final endPillM = _measureText(endLabel);
  final endPillY = y + kRowGap;
  primitives.add(_EndPill(kPillLeft, endPillY, endPillM.w, endLabel));
  final endPillMidY = endPillY + kPillH / 2;

  // Root scope vline
  if (tabYs.isNotEmpty) {
    primitives.add(_VLine(kRootScopeX, beginBottom, endPillMidY));
  }

  // Compute canvas size
  var maxX = 200.0;
  for (final p in primitives) {
    if (p is _Rect)      maxX = math.max(maxX, p.x + p.w + kT * 2);
    if (p is _ReturnPill)maxX = math.max(maxX, p.x + p.w + kT * 2);
    if (p is _HLine)     maxX = math.max(maxX, p.x2 + kT * 2);
    if (p is _Diamond)   maxX = math.max(maxX, p.cx + kDHx + kT * 2);
    if (p is _Clock)     maxX = math.max(maxX, p.cx + kDHy + kT * 2);
  }
  final totalW = maxX;
  final totalH = endPillY + kPillH + kT * 4;

  return _DiagramLayout(primitives, totalW, totalH);
}

// ─── SVG serialiser ───────────────────────────────────────────────────────────

String _f(double v) {
  // Emit compact numbers — drop trailing zeros after decimal point
  final s = v.toStringAsFixed(2);
  if (s.contains('.')) {
    return s.replaceAll(RegExp(r'\.?0+$'), '');
  }
  return s;
}

String _xmlEscape(String s) => s
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');

String _renderPrimitive(_Primitive p) {
  if (p is _HLine || p is _VLine) {
    double x1, y1, x2, y2;
    if (p is _HLine) {
      x1 = p.x1; y1 = p.y; x2 = p.x2; y2 = p.y;
    } else {
      final v = p as _VLine;
      x1 = v.x; y1 = v.y1; x2 = v.x; y2 = v.y2;
    }
    return '<line x1="${_f(x1)}" y1="${_f(y1)}" x2="${_f(x2)}" y2="${_f(y2)}" '
        'stroke="$cLine" stroke-width="1.5"/>';
  }

  if (p is _UArc) {
    final l = p.leftX, r = p.rightX, t = p.topY, b = p.bottomY;
    final rad = kURadius;
    return '<path d="M ${_f(l)} ${_f(t)} '
        'L ${_f(l)} ${_f(b - rad)} '
        'Q ${_f(l)} ${_f(b)} ${_f(l + rad)} ${_f(b)} '
        'L ${_f(r - rad)} ${_f(b)} '
        'Q ${_f(r)} ${_f(b)} ${_f(r)} ${_f(b - rad)} '
        'L ${_f(r)} ${_f(t)}" '
        'fill="none" stroke="$cLine" stroke-width="1.5"/>';
  }

  if (p is _Rect) {
    final stroke = p.indigo ? cIndigo : cRectStroke;
    final sw     = p.indigo ? '1.5' : '1';
    final buf = StringBuffer();
    buf.write('<rect x="${_f(p.x)}" y="${_f(p.y)}" '
        'width="${_f(p.w)}" height="${_f(p.h)}" '
        'fill="$cWhite" stroke="$stroke" stroke-width="$sw" rx="2"/>');
    for (var i = 0; i < p.lines.length; i++) {
      final ty = p.textY + i * (kT + kLineGap) + kT * 0.78;
      buf.write('<text x="${_f(p.textX)}" y="${_f(ty)}" '
          'fill="$cText" font-size="${_f(kT)}" '
          'font-family="\'IBM Plex Mono\',monospace">'
          '${_xmlEscape(p.lines[i])}</text>');
    }
    return buf.toString();
  }

  if (p is _ReturnPill) {
    final rx = p.h / 2;
    final tx = p.x + p.w / 2;
    final ty = p.y + p.h / 2 + kT * 0.35;
    return '<rect x="${_f(p.x)}" y="${_f(p.y)}" '
        'width="${_f(p.w)}" height="${_f(p.h)}" '
        'fill="$cReturnFill" stroke="$cReturnStroke" stroke-width="1.5" rx="${_f(rx)}"/>'
        '<text x="${_f(tx)}" y="${_f(ty)}" '
        'fill="$cReturnText" font-size="${_f(kT)}" '
        'font-family="\'IBM Plex Mono\',monospace" '
        'text-anchor="middle" font-weight="bold">'
        '${_xmlEscape(p.text)}</text>';
  }

  if (p is _FlankLines) {
    return '<line x1="${_f(p.x1)}" y1="${_f(p.y1)}" x2="${_f(p.x1)}" y2="${_f(p.y2)}" '
        'stroke="$cIndigo" stroke-width="1.5"/>'
        '<line x1="${_f(p.x2)}" y1="${_f(p.y1)}" x2="${_f(p.x2)}" y2="${_f(p.y2)}" '
        'stroke="$cIndigo" stroke-width="1.5"/>';
  }

  if (p is _AwaitBadge) {
    final cx = p.cx, cy = p.cy, r = kBadgeR;
    return '<circle cx="${_f(cx)}" cy="${_f(cy)}" r="${_f(r)}" '
        'fill="$cAwaitBadge" stroke="$cIndigo" stroke-width="1"/>'
        '<line x1="${_f(cx)}" y1="${_f(cy)}" '
        'x2="${_f(cx)}" y2="${_f(cy - r * 0.6)}" stroke="$cIndigo" stroke-width="1"/>'
        '<line x1="${_f(cx)}" y1="${_f(cy)}" '
        'x2="${_f(cx + r * 0.45)}" y2="${_f(cy + r * 0.1)}" stroke="$cIndigo" stroke-width="1"/>'
        '<circle cx="${_f(cx)}" cy="${_f(cy)}" r="1.5" fill="$cIndigo"/>';
  }

  if (p is _Diamond) {
    final cx = p.cx, cy = p.cy;
    return '<polygon points="${_f(cx)},${_f(cy - kDHy)} '
        '${_f(cx + kDHx)},${_f(cy)} '
        '${_f(cx)},${_f(cy + kDHy)} '
        '${_f(cx - kDHx)},${_f(cy)}" '
        'fill="$cWhite" stroke="$cLine" stroke-width="1.5"/>';
  }

  if (p is _Clock) {
    final cx = p.cx, cy = p.cy, r = kDHy;
    return '<circle cx="${_f(cx)}" cy="${_f(cy)}" r="${_f(r)}" '
        'fill="$cWhite" stroke="$cIndigo" stroke-width="1.5"/>'
        '<line x1="${_f(cx)}" y1="${_f(cy)}" '
        'x2="${_f(cx)}" y2="${_f(cy - r * 0.55)}" stroke="$cIndigo" stroke-width="1.5"/>'
        '<line x1="${_f(cx)}" y1="${_f(cy)}" '
        'x2="${_f(cx + r * 0.45)}" y2="${_f(cy + r * 0.1)}" stroke="$cIndigo" stroke-width="1.5"/>'
        '<circle cx="${_f(cx)}" cy="${_f(cy)}" r="1.5" fill="$cIndigo"/>';
  }

  if (p is _BeginPill || p is _EndPill) {
    final double x, y, w;
    final String label;
    if (p is _BeginPill) {
      x = p.x; y = p.y; w = p.w; label = p.label;
    } else {
      final ep = p as _EndPill;
      x = ep.x; y = ep.y; w = ep.w; label = ep.label;
    }
    final rx = kPillH / 2;
    final tx = x + w / 2;
    final ty = y + kPillH / 2 + kT * 0.35;
    return '<rect x="${_f(x)}" y="${_f(y)}" '
        'width="${_f(w)}" height="${_f(kPillH)}" '
        'fill="$cPillBg" stroke="$cLine" stroke-width="1" rx="${_f(rx)}"/>'
        '<text x="${_f(tx)}" y="${_f(ty)}" '
        'fill="$cText" font-size="${_f(kT)}" '
        'font-family="\'IBM Plex Mono\',monospace" text-anchor="middle">'
        '${_xmlEscape(label)}</text>';
  }

  return '';
}

// ─── Public API ───────────────────────────────────────────────────────────────

/// Converts an Algorithm JSON object (already decoded via [jsonDecode]) into
/// a self-contained SVG string.
///
/// Example:
/// ```dart
/// final svg = algorithmToSvg(jsonDecode(algorithmJson));
/// ```
String algorithmToSvg(Map<String, dynamic> algorithm) {
  final layout = _layoutAlgorithm(algorithm);
  final w = layout.width;
  final h = layout.height;

  // Z-order: lines & arcs first, then shapes
  bool isLine(_Primitive p) =>
      p is _HLine || p is _VLine || p is _UArc;

  final lines  = layout.primitives.where(isLine).toList();
  final shapes = layout.primitives.where((p) => !isLine(p)).toList();

  final buf = StringBuffer();

  buf.write('<?xml version="1.0" encoding="UTF-8"?>');
  buf.write('<svg xmlns="http://www.w3.org/2000/svg" '
      'width="${_f(w)}" height="${_f(h)}" '
      'viewBox="0 0 ${_f(w)} ${_f(h)}">');

  // Background
  buf.write('<rect width="${_f(w)}" height="${_f(h)}" fill="$cBg"/>');

  // Dot grid
  final dotSpacing = 2 * kT;
  buf.write('<g>');
  for (var dx = 0.0; dx < w; dx += dotSpacing) {
    for (var dy = 0.0; dy < h; dy += dotSpacing) {
      buf.write('<circle cx="${_f(dx)}" cy="${_f(dy)}" r="1" fill="$cDot"/>');
    }
  }
  buf.write('</g>');

  // Lines
  buf.write('<g>');
  for (final p in lines) {
    buf.write(_renderPrimitive(p));
  }
  buf.write('</g>');

  // Shapes
  buf.write('<g>');
  for (final p in shapes) {
    buf.write(_renderPrimitive(p));
  }
  buf.write('</g>');

  buf.write('</svg>');
  return buf.toString();
}

// ─── Schema ───────────────────────────────────────────────────────────────────

// Embedded Algorithm JSON Schema (algorithm.schema.json).
// Kept here so validation works without asset loading.
final _kAlgorithmSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  r'$id': 'algorithm.schema.json',
  'title': 'Algorithm',
  'description': 'A schema for storing an Algorithm as JSON',
  'type': 'object',
  'required': ['name', 'description', 'steps'],
  'additionalProperties': false,
  'properties': {
    'name':        {'type': 'string'},
    'description': {'type': 'string'},
    'parameters':  {'type': 'array', 'items': {r'$ref': r'#/$defs/Parameter'}},
    'steps':       {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
  },
  r'$defs': {
    'Parameter': {
      'type': 'object',
      'required': ['name', 'type'],
      'additionalProperties': false,
      'properties': {
        'name':        {'type': 'string'},
        'type':        {'type': 'string'},
        'description': {'type': 'string'},
        'default':     {},
      },
    },
    'Step': {
      'type': 'object',
      'required': ['type'],
      'oneOf': [
        {r'$ref': r'#/$defs/Action'},
        {r'$ref': r'#/$defs/Loop'},
        {r'$ref': r'#/$defs/Decision'},
        {r'$ref': r'#/$defs/Function'},
        {r'$ref': r'#/$defs/AwaitFunctionCall'},
        {r'$ref': r'#/$defs/AsyncFunctionCall'},
        {r'$ref': r'#/$defs/Return'},
      ],
    },
    'Action': {
      'type': 'object',
      'required': ['type', 'txt'],
      'additionalProperties': false,
      'properties': {
        'type': {'const': 'Action'},
        'txt':  {'type': 'string'},
      },
    },
    'Loop': {
      'type': 'object',
      'required': ['type', 'txt', 'steps'],
      'additionalProperties': false,
      'properties': {
        'type':  {'const': 'Loop'},
        'txt':   {'type': 'string'},
        'steps': {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
      },
    },
    'Decision': {
      'type': 'object',
      'required': ['type', 'condition', 'trueSteps', 'falseSteps'],
      'additionalProperties': false,
      'properties': {
        'type':       {'const': 'Decision'},
        'condition':  {'type': 'string'},
        'trueSteps':  {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
        'falseSteps': {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
      },
    },
    'Function': {
      'type': 'object',
      'required': ['type', 'id', 'name', 'steps'],
      'additionalProperties': false,
      'properties': {
        'type':        {'const': 'Function'},
        'id':          {'type': 'string'},
        'name':        {'type': 'string'},
        'description': {'type': 'string'},
        'parameters':  {'type': 'array', 'items': {r'$ref': r'#/$defs/Parameter'}},
        'steps':       {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
      },
    },
    'AwaitFunctionCall': {
      'type': 'object',
      'required': ['type', 'functionId'],
      'additionalProperties': false,
      'properties': {
        'type':       {'const': 'AwaitFunctionCall'},
        'label':      {'type': 'string'},
        'functionId': {'type': 'string'},
        'arguments':  {'type': 'object'},
      },
    },
    'AsyncFunctionCall': {
      'type': 'object',
      'required': ['type', 'functionId', 'successSteps', 'failedSteps'],
      'additionalProperties': false,
      'properties': {
        'type':         {'const': 'AsyncFunctionCall'},
        'label':        {'type': 'string'},
        'functionId':   {'type': 'string'},
        'arguments':    {'type': 'object'},
        'successSteps': {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
        'failedSteps':  {'type': 'array', 'items': {r'$ref': r'#/$defs/Step'}},
      },
    },
    'Return': {
      'type': 'object',
      'required': ['type'],
      'additionalProperties': false,
      'properties': {
        'type':            {'const': 'Return'},
        'label':           {'type': 'string'},
        'value':           {},
        'valueExpression': {'type': 'string'},
      },
    },
  },
};

// ─── Public API — Validation ──────────────────────────────────────────────────

/// Result of validating an Algorithm JSON object.
class AlgorithmValidationResult {
  /// Whether the object is valid against the Algorithm schema.
  final bool isValid;

  /// Validation errors, empty if [isValid] is true.
  final List<String> errors;

  const AlgorithmValidationResult._({required this.isValid, required this.errors});

  @override
  String toString() => isValid
      ? 'AlgorithmValidationResult(valid)'
      : 'AlgorithmValidationResult(errors: $errors)';
}

/// Validates [algorithm] (an already-decoded JSON map) against the
/// Algorithm schema.
///
/// Example:
/// ```dart
/// final result = validateAlgorithm(jsonDecode(algorithmJson));
/// if (result.isValid) {
///   final svg = algorithmToSvg(result);
/// } else {
///   print(result.errors);
/// }
/// ```
AlgorithmValidationResult validateAlgorithm(Map<String, dynamic> algorithm) {
  final schema = JsonSchema.create(_kAlgorithmSchema);
  final result = schema.validate(algorithm);
  return AlgorithmValidationResult._(
    isValid: result.isValid,
    errors: result.errors.map((e) => e.toString()).toList(),
  );
}