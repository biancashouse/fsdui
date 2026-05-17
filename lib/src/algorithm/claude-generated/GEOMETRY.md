# Geometry Specification

All spatial constants are multiples of `t` (the font size in pixels, default 14).
Changing `t` rescales the entire diagram proportionally.

---

## Constants

```
t                  = 14px       Base unit (font size)

CHAR_W             = 0.6 * t    Monospace char width (IBM Plex Mono)
PAD_X              = t          Horizontal padding inside rect (each side)
PAD_Y              = 0.6 * t    Vertical padding inside rect (top and bottom)
LINE_GAP           = 4px        Gap between lines of text inside rect

ROW_GAP            = 1.5t       Vertical gap between siblings in a scope
TAB                = 2t         Horizontal tab: scope line → rect left edge

D_HX               = t          Diamond / clock icon half-width
D_HY               = t          Diamond / clock icon half-height
D_CX_OFF           = 2t         Icon centre x = rectX + 2t
D_CY_OFF           = 2.5t       Icon centre y = rectBottom + 2.5t

BRANCH_SCOPE_X_OFF = 4t         True/success/false/fail scope line x = iconCX + 4t
BRANCH_RECT_X_OFF  = 6t         True/success/false/fail rect left    = iconCX + 6t
FALSE_TOP_GAP      = 2t         False/fail first rect top = successBottomY + 2t

U_L_OFF            = 2t         Loop U left arm x  = rectX + 2t
U_R_OFF            = 4t         Loop U right arm x = rectX + 4t  (also scope line)
U_RADIUS           = t          Loop U corner radius
U_PAD              = t          Padding below last loop child to U bottom

FLANK_INNER_OFF    = t/2        Flanking line x from rect edges (inward)
FLANK_EXTRA_W      = t          Extra width added to flanked rects

FUNC_SCOPE_X_OFF   = 2t         Function child scope line x = rectX + 2t

BADGE_R            = 0.55t      Await clock badge radius

PILL_LEFT          = 2t         Begin/End pill left edge x from canvas left
PILL_H             = 1.5t       Begin/End pill height
ROOT_SCOPE_X       = 4t         Root scope line x  (= PILL_LEFT + 2t)
```

---

## Step Display Text

Each step type derives its rect label from its JSON fields as follows:

| Step type          | Display text |
|--------------------|--------------|
| `Action`           | `txt` |
| `Loop`             | `txt` |
| `Decision`         | `condition` |
| `Function`         | `name` |
| `AwaitFunctionCall`| `label` if present, else `functionId` |
| `AsyncFunctionCall`| `label` if present, else `functionId` |
| `Return`           | `"return " + label` if label present; else `"return " + valueExpression`; else `"return " + JSON.stringify(value)`; else `"return"` |

---

## Text Box Measurement

```
lines    = text.split('\n')
maxChars = max(lines.map(l => l.length))

w = ceil(maxChars * CHAR_W + 2 * PAD_X)
  + (isFlanked ? FLANK_EXTRA_W : 0)

rawH = lines.length * t
     + (lines.length - 1) * LINE_GAP
     + 2 * PAD_Y

h = ceil(rawH / t) * t          ← always a multiple of t
```

**Flanked types** (wider by `t`): `Function`, `AwaitFunctionCall`, `AsyncFunctionCall`.

**Text x offset** inside flanked rects: `rectX + PAD_X + FLANK_INNER_OFF`
(shifts text right to clear the left flanking line).

**Text y offset** for line `i` (0-based): `rectY + PAD_Y + i * (t + LINE_GAP) + t * 0.78`

---

## Rect Decoration

### Action
Plain rect. No extra decoration.

### Decision
Plain rect. Diamond below (see Diamond section).

### Loop
Plain rect. U-arc below (see Loop U-Arc section).

### Return
Amber pill (stadium shape). `rx = h / 2`. Text centred, bold, amber.
No flanking. No scope below.

### Function
- Indigo border (stroke width 1.5)
- Inner vertical flanking lines (see Flanking Lines section)
- Vertical child scope below (see Function Child Scope section)
- Flanking lines suppressed when this step is the first child in a
  true/success scope

### AwaitFunctionCall
- Indigo border (stroke width 1.5)
- Inner vertical flanking lines (see Flanking Lines section)
- Clock badge in the left channel between the rect left edge and the
  left flanking line (see Await Clock Badge section)
- Flanking lines (but NOT the badge) suppressed when this step is the
  first child in a true/success scope
- No scope below

### AsyncFunctionCall
- Indigo border (stroke width 1.5)
- Inner vertical flanking lines (see Flanking Lines section)
- Clock icon below (see Clock Icon section)
- True/success + false/fail branch scopes below (same layout as Decision)
- Flanking lines suppressed when this step is the first child in a
  true/success scope

---

## Flanking Lines

Applies to `Function`, `AwaitFunctionCall`, `AsyncFunctionCall`
(unless suppressed — see Suppress Flanking Rule).

```
x1 = rectX + FLANK_INNER_OFF          left flanking line
x2 = rectX + w - FLANK_INNER_OFF      right flanking line
y1 = rectY + 2                         2px inset from top
y2 = rectY + h - 2                     2px inset from bottom
```

Both lines: indigo `#6366F1`, stroke width 1.5.

---

## Await Clock Badge (AwaitFunctionCall)

A small clock icon centred in the left channel (between left rect border
and left flanking line), at the vertical midpoint of the rect.

```
cx = rectX + FLANK_INNER_OFF / 2      midpoint of left channel
cy = rectY + h / 2

circle: r = BADGE_R = 0.55t
        fill: #EEF2FF, stroke: #6366F1, stroke-width: 1

12 o'clock hand: (cx, cy) → (cx, cy - BADGE_R * 0.6)
3  o'clock hand: (cx, cy) → (cx + BADGE_R * 0.45, cy + BADGE_R * 0.1)
centre dot: r = 1.5px, fill: #6366F1
```

The badge always renders, even when flanking lines are suppressed.

---

## Diamond (Decision)

```
centre:  cx = rectX + D_CX_OFF        = rectX + 2t
         cy = rectBottom + D_CY_OFF   = rectBottom + 2.5t

points:  top    (cx,    cy - t)
         right  (cx+t,  cy)
         bottom (cx,    cy + t)
         left   (cx-t,  cy)
```

Vertical connector: `rectBottom` → `cy - t` (rect bottom to diamond top).
Horizontal connector: `(cx + t, cy)` → `(rectX + BRANCH_SCOPE_X_OFF, cy)`
(diamond right to true/success scope line).

---

## Clock Icon (AsyncFunctionCall)

Same bounding box and centre formula as the Diamond.

```
centre:  cx = rectX + D_CX_OFF
         cy = rectBottom + D_CY_OFF
radius:  r = D_HY = t

circle: fill: #FFFFFF, stroke: #6366F1, stroke-width: 1.5

12 o'clock hand: (cx, cy) → (cx, cy - r * 0.55)
3  o'clock hand: (cx, cy) → (cx + r * 0.45, cy + r * 0.1)
centre dot: r = 1.5px, fill: #6366F1
```

Vertical connector (rect bottom → clock top): `rectBottom` → `cy - t`
Horizontal connector (clock right → success scope): `(cx + t, cy)` → `(rectX + BRANCH_SCOPE_X_OFF, cy)`

---

## Loop U-Arc

```
leftX  = rectX + U_L_OFF    = rectX + 2t
rightX = rectX + U_R_OFF    = rectX + 4t   ← also the scope line x
topY   = rectBottom

children laid out with layoutScope(children, rightX, topY + ROW_GAP)
loopBottomY = childResult.bottomY + U_PAD

SVG path:
  M leftX topY
  L leftX (loopBottomY - U_RADIUS)
  Q leftX loopBottomY  (leftX + U_RADIUS) loopBottomY
  L (rightX - U_RADIUS) loopBottomY
  Q rightX loopBottomY  rightX (loopBottomY - U_RADIUS)
  L rightX topY

stepBottomY = loopBottomY + ROW_GAP
```

---

## Scope Line Rules

### Root Scope
- Vertical line at `x = ROOT_SCOPE_X = 4t`
- Runs from Begin pill bottom to End pill vertical midpoint
  (`endPillY + PILL_H / 2`)
- Each step: `hline` from `ROOT_SCOPE_X` to `ROOT_SCOPE_X + TAB` at
  `y = stepRectY + rectH / 2`
- Root scope line always drawn (even for a single root step)

### Generic Scope (Loop children)
- Vertical scope line at `attachX` (= `rectX + U_R_OFF` for loops)
- Each step: `hline` from `attachX` to `attachX + TAB` at `y = rectY + h / 2`
- Scope line drawn only if ≥ 2 children: from `tabYs[0]` to `tabYs[last]`
- Single child: no vertical scope line, just the horizontal tab

### True / Success Scope (Decision + AsyncFunctionCall)
- Scope line at `iconCX + BRANCH_SCOPE_X_OFF`  (= `rectX + 2t + 4t = rectX + 6t`... wait —
  `iconCX = rectX + D_CX_OFF = rectX + 2t`, so scope line at `rectX + 2t + 4t = rectX + 6t`)

  > Note: in the implementation `BRANCH_SCOPE_X_OFF` is applied relative to
  > `decRectX` (the step's own rectX), not `iconCX`. So:
  > `scopeX = decRectX + BRANCH_SCOPE_X_OFF = decRectX + 4t`
  > `rectX  = decRectX + BRANCH_RECT_X_OFF  = decRectX + 6t`

- **First rect vertical midpoint aligns with `dCY`**:
  `firstRectTop = dCY - firstH / 2`
- Subsequent steps: normal ROW_GAP below previous step's `bottomY`
- Each step: `hline` from `scopeX` to `rectX` at `y = rectMidY`
- Scope line (if ≥ 2 children): from `tabYs[0]` to `tabYs[last]`
- Returns `bottomY` = full rendered bottom of last step including all
  nested children (used to position false/fail scope)
- **Flanking suppressed** on the first child (index 0)

### False / Fail Scope (Decision + AsyncFunctionCall)

Mirrors the true/success layout — same `BRANCH_SCOPE_X_OFF` and
`BRANCH_RECT_X_OFF` offsets, applied from `iconCX` (not `decRectX`).

```
scopeX        = dCX + BRANCH_SCOPE_X_OFF    = dCX + 4t
rectX         = dCX + BRANCH_RECT_X_OFF     = dCX + 6t
firstRectTop  = successScope.bottomY + FALSE_TOP_GAP
firstMidY     = firstRectTop + firstH / 2
```

Connectors:
- Vertical: `(dCX, dCY + D_HY)` → `(dCX, firstMidY)`  (icon bottom → first rect mid)
- Horizontal: `(dCX, firstMidY)` → `(scopeX, firstMidY)` (vline → scope line)

Each step: `hline` from `scopeX` to `rectX` at `y = rectMidY`
Scope line (if ≥ 2 children): from `tabYs[0]` to `tabYs[last]`
**No flanking suppression** on the first false/fail child.

### Function Child Scope
- Scope line at `rectX + FUNC_SCOPE_X_OFF = rectX + 2t`
- Child rect left edge at `rectX + 2t + TAB = rectX + 4t`
- Starts at `rectBottom` (no diamond/clock offset)
- Each step: `hline` from `scopeX` to `childRectX` at `y = rectMidY`
- Multiple children (≥ 2): scope line from `rectBottom` to `tabYs[last]`
- Single child: short `vline` from `rectBottom` to `tabY`, then `hline`
- **Not a U-arc** — straight vertical scope line like root/true/false

---

## Canvas and Begin/End Pills

```
Begin pill:
  x      = PILL_LEFT = 2t
  y      = 2t
  w      = measured from algorithm.name text
  h      = PILL_H = 1.5t
  rx     = PILL_H / 2

beginBottom = 2t + PILL_H = 3.5t

Root steps start at y = beginBottom + ROW_GAP * 2

End pill:
  x      = PILL_LEFT = 2t
  y      = lastStepBottomY + ROW_GAP * 2
  w      = measured from "End" text
  h      = PILL_H = 1.5t
  rx     = PILL_H / 2
  label  = "End"

endPillMidY = endPillY + PILL_H / 2

Root scope vline: y1 = beginBottom, y2 = endPillMidY
```

Canvas total height: `endPillY + PILL_H + 4t`
Canvas total width: derived from rightmost rendered element + `4t` margin

---

## Suppress Flanking Rule

When a `Function`, `AwaitFunctionCall`, or `AsyncFunctionCall` appears as
the **first child (index 0) in a true/success scope**, its flanking lines
are suppressed.

- The `suppressFlanking` flag is passed only from `layoutTrueScope`, only
  for `i === 0`.
- It is **not** applied in false/fail scopes, generic scopes, function
  scopes, or the root scope.
- When flanking is suppressed, the rect is still measured and rendered as
  if flanked (same width, same text x offset) — only the visible flanking
  lines are omitted.
- For `AwaitFunctionCall`, the clock badge is **not** suppressed — it
  always renders regardless of the `suppressFlanking` flag.

---

## Z-Order

Lines and arcs are rendered first (behind), shapes second (in front).

**Lines / arcs**: `hline`, `vline`, `scope_vline`, `root_vline`, `u_arc`

**Shapes**: `rect`, `return_pill`, `return_text`, `flank_lines`,
`diamond`, `clock`, `await_badge`, `begin_pill`, `end_pill`

---

## Canvas

- Background: `#FAFBFC`
- Dot grid: `#DDE3EA`, dot radius 1px, spacing `2t × 2t`
- Scope / connector lines: `#A8B3BE`, stroke width 1.5px
- Rect stroke (plain): `#A8B3BE`, stroke width 1px, rx 2px
- Rect stroke (Function / AwaitFunctionCall / AsyncFunctionCall): `#6366F1`, stroke width 1.5px
- Rect fill: `#FFFFFF`
- Text: `#1F2937`, font IBM Plex Mono, size `t`
- Flanking lines: `#6366F1`, stroke width 1.5px
- Clock icon (AsyncFunctionCall): stroke/hands `#6366F1`, fill `#FFFFFF`
- Await badge fill: `#EEF2FF`, stroke: `#6366F1`, stroke width 1px
- Return pill fill: `#FEF3C7`, stroke: `#D97706`, stroke width 1.5px
- Return text: `#D97706`, bold, centred
- Begin/End pill fill: `#F5F7FA`, stroke: `#A8B3BE`, stroke width 1px

---

## Key Design Decisions

| Decision | Rationale |
|---|---|
| False/fail scope mirrors true/success layout | Both branch types use `BRANCH_SCOPE_X_OFF` / `BRANCH_RECT_X_OFF` offsets. Symmetry makes the diagram readable — left branch hangs right of the icon, bottom branch hangs below it but with the same indentation logic. |
| False/fail rect top = `successBottomY + 2t` | Accounts for the full rendered height of the success scope including nested U-arcs and sub-scopes. Using the last rect bottom alone ignores children of the last step. |
| True/success first rect midpoint = `dCY` | The horizontal connecting line from the icon right hits the rect at its visual centre regardless of how many text lines the rect has. |
| `AwaitFunctionCall` is flanked | Visual consistency with `Function` and `AsyncFunctionCall` — all three are call/invocation types and share the indigo + flanking visual language. |
| Await badge at `rectX + FLANK_INNER_OFF / 2` | Centres the badge in the narrow strip between the left rect border and the left flanking line, mirroring the clock icon placement on `AsyncFunctionCall`. |
| Await badge never suppressed | The badge is the primary identity marker of the step type. Suppressing it would make an `AwaitFunctionCall` indistinguishable from a plain rect when flanking is suppressed. |
| Function scope = vertical line, not U-arc | Functions are not loops. The U-arc signals repetition. A straight vertical scope reads as sequential, like a code block. |
| Flanking lines inside rect, rect wider by `t` | Putting them outside looked disconnected. Inside and wider keeps the decoration clearly part of the rect. |
| Suppress flanking on first true/success child | The left edge of the first true/success rect is already visually connected by the horizontal tab from the scope line. Adding flanking lines there creates visual noise at the junction. |
| Single-child scopes: no vertical scope line | A vertical line with a single tab looks like a dead end. For single children, the horizontal tab alone is sufficient and cleaner. |
| Height always a multiple of `t` | Ensures vertical midpoints fall on round pixel values, keeping all connecting lines crisp at any display density. |
| Return text always prefixed `"return "` | Makes the pill immediately readable without needing to know the step type from context. |